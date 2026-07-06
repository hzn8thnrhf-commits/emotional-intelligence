import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var state: AppState
    @State private var showCheckIn = false
    @State private var showReset = false
    @State private var showSettings = false

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let name = state.userName.isEmpty ? "" : ", \(state.userName)"
        switch hour {
        case 5..<12: return "Good morning\(name)"
        case 12..<18: return "Good afternoon\(name)"
        case 18..<23: return "Good evening\(name)"
        default: return "Still up\(name)?"
        }
    }

    private var quote: (text: String, source: String) {
        let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        return ContentLibrary.quotes[day % ContentLibrary.quotes.count]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    resetCard
                    checkInCard
                    if let (course, lesson) = state.nextLesson {
                        nextLessonCard(course: course, lesson: lesson)
                    }
                    quickToolsRow
                    quoteCard
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .screenBackground()
            .navigationTitle(greeting)
            .toolbar {
                Button { showSettings = true } label: {
                    Image(systemName: "gearshape")
                }
            }
            .sheet(isPresented: $showCheckIn) { CheckInView() }
            .fullScreenCover(isPresented: $showReset) { ResetView() }
            .sheet(isPresented: $showSettings) { SettingsView() }
        }
    }

    private var resetCard: some View {
        Button { showReset = true } label: {
            HStack(spacing: 14) {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.white)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Reset")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text("Hard moment? Sixty guided seconds.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.7))
            }
            .padding(18)
            .background(
                LinearGradient(colors: [Theme.teal, Theme.indigo],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var checkInCard: some View {
        Group {
            if let today = state.todayCheckIn {
                HStack(spacing: 14) {
                    Image(systemName: CheckIn.moodSymbol(today.mood))
                        .font(.system(size: 30))
                        .foregroundStyle(Theme.teal)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Today: \(CheckIn.moodLabel(today.mood).lowercased())")
                            .font(.headline)
                        Text(today.emotions.isEmpty
                             ? "Checked in. You can log again any time."
                             : today.emotions.map(\.rawValue).joined(separator: " · "))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Button("Again") { showCheckIn = true }
                        .font(.subheadline.weight(.medium))
                }
                .cardStyle()
            } else {
                Button { showCheckIn = true } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "cloud.sun")
                            .font(.system(size: 30))
                            .foregroundStyle(Theme.teal)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Check in")
                                .font(.headline)
                            Text("Fifteen seconds. What's the weather in there?")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .cardStyle()
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func nextLessonCard(course: Course, lesson: Lesson) -> some View {
        NavigationLink {
            LessonView(course: course, lesson: lesson)
        } label: {
            HStack(spacing: 14) {
                Image(systemName: course.symbol)
                    .font(.system(size: 26))
                    .foregroundStyle(course.tint)
                    .frame(width: 36)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Next up · \(course.title)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                    Text(lesson.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    Text("\(lesson.minutes) min read")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.tertiary)
            }
            .cardStyle()
        }
        .buttonStyle(.plain)
    }

    private var quickToolsRow: some View {
        HStack(spacing: 12) {
            NavigationLink {
                BreathingView(pattern: .box)
            } label: {
                quickTool(symbol: "wind", label: "Breathe")
            }
            NavigationLink {
                GroundingView()
            } label: {
                quickTool(symbol: "hand.raised", label: "Ground")
            }
            NavigationLink {
                DecompressView()
            } label: {
                quickTool(symbol: "moon.stars", label: "Decompress")
            }
        }
        .buttonStyle(.plain)
    }

    private func quickTool(symbol: String, label: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: symbol)
                .font(.title3)
                .foregroundStyle(Theme.teal)
            Text(label)
                .font(.footnote.weight(.medium))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .cardStyle()
    }

    private var quoteCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\u{201C}\(quote.text)\u{201D}")
                .font(.system(.callout, design: .serif))
                .italic()
            Text("— \(quote.source)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
