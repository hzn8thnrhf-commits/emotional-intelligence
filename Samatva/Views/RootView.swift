import SwiftUI

struct RootView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        if state.hasOnboarded {
            TabView {
                TodayView()
                    .tabItem { Label("Today", systemImage: "sun.horizon") }
                LearnView()
                    .tabItem { Label("Learn", systemImage: "book") }
                ToolkitView()
                    .tabItem { Label("Toolkit", systemImage: "wind") }
                ReflectView()
                    .tabItem { Label("Reflect", systemImage: "chart.line.uptrend.xyaxis") }
            }
        } else {
            OnboardingView()
        }
    }
}

struct OnboardingView: View {
    @EnvironmentObject private var state: AppState
    @State private var name = ""
    @State private var page = 0

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $page) {
                intro.tag(0)
                philosophy.tag(1)
                nameEntry.tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
        }
        .screenBackground()
    }

    private var intro: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "circle.hexagongrid")
                .font(.system(size: 56, weight: .light))
                .foregroundStyle(Theme.teal)
            Text("Samatva")
                .font(.system(.largeTitle, design: .serif, weight: .semibold))
            Text("Equanimity, from the Sanskrit.\n\u{201C}Samatvam yoga ucyate\u{201D} — evenness of mind is excellence in action.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Text("Swipe to continue")
                .font(.footnote)
                .foregroundStyle(.tertiary)
                .padding(.bottom, 60)
        }
    }

    private var philosophy: some View {
        VStack(alignment: .leading, spacing: 24) {
            Spacer()
            ForEach([
                ("book", "Short lessons", "Two to four minutes each, written for demanding days — not another content feed."),
                ("wind", "Tools for the moment", "Breathing, resets and reframes for when frustration or pressure actually hits."),
                ("chart.line.uptrend.xyaxis", "Quiet progress", "Milestones and patterns, at your pace. No streaks, no guilt mechanics."),
                ("lock", "Private by design", "Everything stays on this phone. No accounts, no cloud, no analytics."),
            ], id: \.0) { item in
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: item.0)
                        .font(.title3)
                        .foregroundStyle(Theme.teal)
                        .frame(width: 32)
                    VStack(alignment: .leading, spacing: 3) {
                        Text(item.1).font(.headline)
                        Text(item.2).font(.subheadline).foregroundStyle(.secondary)
                    }
                }
            }
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 36)
    }

    private var nameEntry: some View {
        VStack(spacing: 24) {
            Spacer()
            Text("What should I call you?")
                .font(.system(.title2, design: .serif, weight: .semibold))
            TextField("Your name", text: $name)
                .textFieldStyle(.plain)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 48)
            Button {
                state.userName = name.trimmingCharacters(in: .whitespaces)
                state.hasOnboarded = true
                state.save()
                Haptics.success()
            } label: {
                Text("Begin")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            .padding(.horizontal, 48)
            Spacer()
            Spacer()
        }
    }
}
