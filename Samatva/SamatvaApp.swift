import SwiftUI

@main
struct SamatvaApp: App {
    @StateObject private var state = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(state)
                .tint(Theme.teal)
        }
    }
}
