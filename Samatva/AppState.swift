import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var userName: String = ""
    @Published var hasOnboarded: Bool = false
    @Published var checkIns: [CheckIn] = []
    @Published var journal: [JournalEntry] = []
    @Published var completedLessons: Set<String> = []
    @Published var calmSeconds: Int = 0        // total time spent in breathing / reset exercises
    @Published var reframeCount: Int = 0
    @Published var resetCount: Int = 0

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent("samatva-state.json")
    }()

    init() {
        load()
    }

    // MARK: - Persistence

    private struct Snapshot: Codable {
        var userName: String
        var hasOnboarded: Bool
        var checkIns: [CheckIn]
        var journal: [JournalEntry]
        var completedLessons: Set<String>
        var calmSeconds: Int
        var reframeCount: Int
        var resetCount: Int
    }

    func save() {
        let snapshot = Snapshot(
            userName: userName,
            hasOnboarded: hasOnboarded,
            checkIns: checkIns,
            journal: journal,
            completedLessons: completedLessons,
            calmSeconds: calmSeconds,
            reframeCount: reframeCount,
            resetCount: resetCount
        )
        if let data = try? JSONEncoder().encode(snapshot) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let snapshot = try? JSONDecoder().decode(Snapshot.self, from: data) else { return }
        userName = snapshot.userName
        hasOnboarded = snapshot.hasOnboarded
        checkIns = snapshot.checkIns
        journal = snapshot.journal
        completedLessons = snapshot.completedLessons
        calmSeconds = snapshot.calmSeconds
        reframeCount = snapshot.reframeCount
        resetCount = snapshot.resetCount
    }

    func eraseAll() {
        userName = ""
        hasOnboarded = false
        checkIns = []
        journal = []
        completedLessons = []
        calmSeconds = 0
        reframeCount = 0
        resetCount = 0
        try? FileManager.default.removeItem(at: fileURL)
    }

    // MARK: - Actions

    func addCheckIn(_ checkIn: CheckIn) {
        checkIns.append(checkIn)
        save()
    }

    func addJournal(_ entry: JournalEntry) {
        journal.insert(entry, at: 0)
        save()
    }

    func completeLesson(_ id: String) {
        completedLessons.insert(id)
        save()
    }

    func addCalmSeconds(_ seconds: Int) {
        calmSeconds += seconds
        save()
    }

    // MARK: - Derived

    var todayCheckIn: CheckIn? {
        checkIns.last { Calendar.current.isDateInToday($0.date) }
    }

    func progress(for course: Course) -> Double {
        guard !course.lessons.isEmpty else { return 0 }
        let done = course.lessons.filter { completedLessons.contains($0.id) }.count
        return Double(done) / Double(course.lessons.count)
    }

    var nextLesson: (Course, Lesson)? {
        for course in ContentLibrary.courses {
            if let lesson = course.lessons.first(where: { !completedLessons.contains($0.id) }) {
                return (course, lesson)
            }
        }
        return nil
    }

    var calmMinutes: Int { calmSeconds / 60 }

    /// Gentle pattern observations from recent check-ins. No judgement, just mirrors.
    var insights: [String] {
        var results: [String] = []
        let recent = checkIns.filter { $0.date > Date().addingTimeInterval(-14 * 86400) }
        guard recent.count >= 3 else { return results }

        let difficult = recent.filter { $0.emotions.contains(where: \.isDifficult) }
        if !difficult.isEmpty {
            let eveningCount = difficult.filter {
                Calendar.current.component(.hour, from: $0.date) >= 18
            }.count
            if Double(eveningCount) / Double(difficult.count) > 0.6 {
                results.append("Most of your harder moments land in the evening. A short decompress before you leave the desk may change how the night goes.")
            }
        }

        let contextCounts = Dictionary(grouping: recent.flatMap(\.contexts), by: { $0 })
            .mapValues(\.count)
        if let (topContext, count) = contextCounts.max(by: { $0.value < $1.value }), count >= 3 {
            results.append("\u{201C}\(topContext.rawValue)\u{201D} shows up most often in your check-ins. Worth a look at the Control Map lesson if you haven't yet.")
        }

        let frustrationCount = recent.filter {
            $0.emotions.contains(.frustrated) || $0.emotions.contains(.angry)
        }.count
        if frustrationCount >= 3 {
            results.append("Frustration has come up \(frustrationCount) times in two weeks. The Heat course and the 60-second Reset are built exactly for this.")
        }

        let averageMood = Double(recent.map(\.mood).reduce(0, +)) / Double(recent.count)
        if averageMood >= 3.6 {
            results.append("Your average mood over the last two weeks has been on the brighter side. Notice what's working — that's data too.")
        }

        return results
    }

    // MARK: - Milestones

    static let milestones: [Milestone] = [
        Milestone(id: "first-checkin", title: "First Weather Report", detail: "Logged your first check-in", symbol: "cloud.sun") { !$0.checkIns.isEmpty },
        Milestone(id: "first-lesson", title: "Student of the Self", detail: "Completed your first lesson", symbol: "book") { !$0.completedLessons.isEmpty },
        Milestone(id: "first-reset", title: "Circuit Breaker", detail: "Used a Reset in a hard moment", symbol: "arrow.counterclockwise.circle") { $0.resetCount >= 1 },
        Milestone(id: "calm-10", title: "Ten Quiet Minutes", detail: "10 minutes of breathing practice", symbol: "wind") { $0.calmMinutes >= 10 },
        Milestone(id: "calm-60", title: "The Still Hour", detail: "60 minutes of breathing practice", symbol: "moon.stars") { $0.calmMinutes >= 60 },
        Milestone(id: "reframe-5", title: "Second Opinion", detail: "Reframed 5 difficult thoughts", symbol: "arrow.triangle.2.circlepath") { $0.reframeCount >= 5 },
        Milestone(id: "checkins-10", title: "Honest Ledger", detail: "10 check-ins recorded", symbol: "list.clipboard") { $0.checkIns.count >= 10 },
        Milestone(id: "course-heat", title: "Cooler Head", detail: "Finished the Heat course", symbol: "flame") { state in
            ContentLibrary.courses.first { $0.id == "heat" }.map { course in
                course.lessons.allSatisfy { state.completedLessons.contains($0.id) }
            } ?? false
        },
        Milestone(id: "course-all", title: "Samatva", detail: "Completed every course", symbol: "laurel.leading") { state in
            ContentLibrary.courses.allSatisfy { course in
                course.lessons.allSatisfy { state.completedLessons.contains($0.id) }
            }
        },
    ]

    var earnedMilestones: [Milestone] {
        Self.milestones.filter { $0.isEarned(self) }
    }
}
