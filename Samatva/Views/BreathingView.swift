import SwiftUI

enum BreathPattern: String, CaseIterable, Identifiable {
    case box = "Box breathing"
    case sigh = "Physiological sigh"
    case fourSevenEight = "4-7-8 wind-down"
    case coherent = "Coherent 5.5"

    var id: String { rawValue }

    var subtitle: String {
        switch self {
        case .box: return "4-4-4-4 · steady focus before a big meeting"
        case .sigh: return "Fastest downshift · between meetings"
        case .fourSevenEight: return "For the end of the day, or 2am thoughts"
        case .coherent: return "Five minutes to an even keel"
        }
    }

    // (label, seconds, scale target)
    var phases: [(String, Double, CGFloat)] {
        switch self {
        case .box:
            return [("Breathe in", 4, 1.0), ("Hold", 4, 1.0), ("Breathe out", 4, 0.55), ("Hold", 4, 0.55)]
        case .sigh:
            return [("Inhale", 1.5, 0.85), ("Top-up inhale", 1.0, 1.0), ("Long sigh out", 6, 0.55)]
        case .fourSevenEight:
            return [("Breathe in", 4, 1.0), ("Hold", 7, 1.0), ("Slow exhale", 8, 0.55)]
        case .coherent:
            return [("Breathe in", 5.5, 1.0), ("Breathe out", 5.5, 0.55)]
        }
    }
}

struct BreathingView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss

    @State var pattern: BreathPattern
    @State private var running = false
    @State private var phaseIndex = 0
    @State private var scale: CGFloat = 0.55
    @State private var elapsed = 0
    @State private var phaseTask: Task<Void, Never>?

    var body: some View {
        VStack(spacing: 24) {
            Picker("Pattern", selection: $pattern) {
                ForEach(BreathPattern.allCases) { p in
                    Text(p.rawValue).tag(p)
                }
            }
            .pickerStyle(.menu)
            .disabled(running)

            Text(pattern.subtitle)
                .font(.footnote)
                .foregroundStyle(.secondary)

            Spacer()

            ZStack {
                Circle()
                    .fill(
                        RadialGradient(colors: [Theme.tealSoft.opacity(0.55), Theme.teal.opacity(0.9)],
                                       center: .center, startRadius: 10, endRadius: 140)
                    )
                    .frame(width: 240, height: 240)
                    .scaleEffect(scale)
                Text(running ? pattern.phases[phaseIndex].0 : "Ready")
                    .font(.system(.title3, design: .serif, weight: .medium))
                    .foregroundStyle(.white)
            }
            .frame(height: 300)

            if running {
                Text(timeString)
                    .font(.system(.body, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                running ? stop() : start()
            } label: {
                Text(running ? "Finish" : "Begin")
                    .font(.headline)
                    .frame(maxWidth: 220)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 24)
        }
        .padding()
        .screenBackground()
        .navigationTitle("Breathe")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear { stop() }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if running { elapsed += 1 }
        }
    }

    private var timeString: String {
        String(format: "%d:%02d", elapsed / 60, elapsed % 60)
    }

    private func start() {
        running = true
        elapsed = 0
        phaseIndex = 0
        Haptics.soft()
        runPhase()
    }

    private func runPhase() {
        phaseTask?.cancel()
        let phases = pattern.phases
        let phase = phases[phaseIndex]
        withAnimation(.easeInOut(duration: phase.1)) {
            scale = phase.2
        }
        phaseTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: UInt64(phase.1 * 1_000_000_000))
            guard !Task.isCancelled, running else { return }
            Haptics.light()
            phaseIndex = (phaseIndex + 1) % phases.count
            runPhase()
        }
    }

    private func stop() {
        guard running else { return }
        running = false
        phaseTask?.cancel()
        withAnimation(.easeInOut(duration: 1)) { scale = 0.55 }
        if elapsed >= 15 {
            state.addCalmSeconds(elapsed)
            Haptics.success()
        }
        elapsed = 0
    }
}
