import Foundation
import SwiftUI

// MARK: - Emotions

enum EmotionTag: String, Codable, CaseIterable, Identifiable {
    case calm = "Calm"
    case content = "Content"
    case energised = "Energised"
    case anxious = "Anxious"
    case frustrated = "Frustrated"
    case angry = "Angry"
    case helpless = "Helpless"
    case overwhelmed = "Overwhelmed"
    case drained = "Drained"
    case low = "Low"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .calm: return "leaf"
        case .content: return "sun.max"
        case .energised: return "bolt"
        case .anxious: return "waveform.path.ecg"
        case .frustrated: return "flame"
        case .angry: return "flame.fill"
        case .helpless: return "arrow.down.to.line"
        case .overwhelmed: return "tornado"
        case .drained: return "battery.25percent"
        case .low: return "cloud.rain"
        }
    }

    var isDifficult: Bool {
        switch self {
        case .calm, .content, .energised: return false
        default: return true
        }
    }
}

enum ContextTag: String, Codable, CaseIterable, Identifiable {
    case deadline = "Deadline"
    case meetings = "Meetings"
    case myTeam = "My team"
    case seniors = "Senior stakeholders"
    case markets = "Markets"
    case workload = "Workload"
    case family = "Family"
    case social = "Social life"
    case health = "Sleep & health"
    case other = "Something else"

    var id: String { rawValue }
}

// MARK: - Records

struct CheckIn: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var mood: Int            // 1 (rough) ... 5 (great)
    var emotions: [EmotionTag]
    var contexts: [ContextTag]
    var note: String

    static func moodLabel(_ mood: Int) -> String {
        switch mood {
        case 1: return "Rough"
        case 2: return "Strained"
        case 3: return "Steady"
        case 4: return "Good"
        default: return "Great"
        }
    }

    static func moodSymbol(_ mood: Int) -> String {
        switch mood {
        case 1: return "cloud.heavyrain"
        case 2: return "cloud"
        case 3: return "cloud.sun"
        case 4: return "sun.min"
        default: return "sun.max"
        }
    }
}

enum JournalKind: String, Codable {
    case reflection = "Reflection"
    case reframe = "Reframe"
    case decompress = "Decompress"
    case reset = "Reset"

    var symbol: String {
        switch self {
        case .reflection: return "text.book.closed"
        case .reframe: return "arrow.triangle.2.circlepath"
        case .decompress: return "moon.stars"
        case .reset: return "arrow.counterclockwise.circle"
        }
    }
}

struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var kind: JournalKind
    var title: String
    var body: String
}

// MARK: - Learning content

struct Course: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let symbol: String
    let tint: Color
    let lessons: [Lesson]
}

struct Lesson: Identifiable {
    let id: String
    let title: String
    let minutes: Int
    let sections: [LessonSection]
    let takeaways: [String]
    let reflection: String
    let scenario: Scenario?
}

struct LessonSection: Identifiable {
    var id: String { heading }
    let heading: String
    let body: String
}

struct Scenario {
    let prompt: String
    let options: [ScenarioOption]
}

struct ScenarioOption: Identifiable {
    var id: String { text }
    let text: String
    let isBest: Bool
    let feedback: String
}

// MARK: - Milestones (quiet gamification — no streaks)

struct Milestone: Identifiable {
    let id: String
    let title: String
    let detail: String
    let symbol: String
    let isEarned: (AppState) -> Bool
}
