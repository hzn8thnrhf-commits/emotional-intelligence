import SwiftUI

// A restrained, calm palette: deep sea teal, warm sand, soft ink.
enum Theme {
    static let teal = Color(red: 0.145, green: 0.416, blue: 0.478)
    static let tealSoft = Color(red: 0.353, green: 0.596, blue: 0.639)
    static let sand = Color(red: 0.949, green: 0.925, blue: 0.878)
    static let ember = Color(red: 0.784, green: 0.404, blue: 0.286)
    static let indigo = Color(red: 0.290, green: 0.318, blue: 0.522)
    static let moss = Color(red: 0.396, green: 0.514, blue: 0.376)
    static let plum = Color(red: 0.506, green: 0.353, blue: 0.478)

    static func background(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(red: 0.075, green: 0.09, blue: 0.10) : Color(red: 0.969, green: 0.957, blue: 0.933)
    }

    static func card(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? Color(red: 0.125, green: 0.145, blue: 0.157) : .white
    }
}

struct CardStyle: ViewModifier {
    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .padding(18)
            .background(Theme.card(scheme))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: .black.opacity(scheme == .dark ? 0.0 : 0.05), radius: 10, y: 4)
    }
}

extension View {
    func cardStyle() -> some View { modifier(CardStyle()) }
}

struct ScreenBackground: ViewModifier {
    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .background(Theme.background(scheme).ignoresSafeArea())
    }
}

extension View {
    func screenBackground() -> some View { modifier(ScreenBackground()) }
}

enum Haptics {
    static func light() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    static func soft() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
