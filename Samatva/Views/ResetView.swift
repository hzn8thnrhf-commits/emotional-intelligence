import SwiftUI

// The 60-second circuit breaker for hard moments.
// Pick the state you're in; get a short guided sequence tuned to it.
struct ResetView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss

    enum HotState: String, CaseIterable, Identifiable {
        case anger = "Anger"
        case frustration = "Frustration"
        case helplessness = "Helplessness"
        case overwhelm = "Overwhelm"
        case anxiety = "Anxiety"

        var id: String { rawValue }

        var symbol: String {
            switch self {
            case .anger: return "flame.fill"
            case .frustration: return "flame"
            case .helplessness: return "arrow.down.to.line"
            case .overwhelm: return "tornado"
            case .anxiety: return "waveform.path.ecg"
            }
        }

        var steps: [ResetStep] {
            switch self {
            case .anger:
                return [
                    ResetStep(seconds: 20, title: "Exhale the surge", text: "Breathe in for 4, out for 8. Long exhales, jaw loose, shoulders down. The chemical wave passes in about 90 seconds — you're already inside it."),
                    ResetStep(seconds: 20, title: "Name the boundary", text: "Silently finish this sentence: \u{201C}This anger is protecting…\u{201D} My time? My standards? My team? Naming the value turns heat into information."),
                    ResetStep(seconds: 20, title: "Choose, don't react", text: "One rule: nothing irreversible in the next ten minutes. No sent email, no verdict. Decide your one calm next step — then take only that."),
                ]
            case .frustration:
                return [
                    ResetStep(seconds: 20, title: "Drop the shoulders", text: "Slow breath in, long breath out. Unclench the jaw and hands. Frustration lives in the body first — release the grip."),
                    ResetStep(seconds: 20, title: "Find the blockage", text: "Frustration = a goal that's blocked. Name the goal, name the blocker. Is the blocker in your control, your influence, or just weather?"),
                    ResetStep(seconds: 20, title: "One micro-move", text: "Pick the smallest action that puts anything back in motion — one message, one decision, one 15-minute slot booked. Motion dissolves frustration."),
                ]
            case .helplessness:
                return [
                    ResetStep(seconds: 20, title: "Feet on the floor", text: "Breathe out slowly. Feel your feet, your seat, your hands. You are here, and this is one situation — not your whole life."),
                    ResetStep(seconds: 20, title: "Shrink the frame", text: "The feeling says \u{201C}nothing I do matters.\u{201D} Test it: name one thing in this mess that is genuinely yours to move, however small."),
                    ResetStep(seconds: 20, title: "Prove it", text: "Do — or schedule — that one thing in the next hour. Agency is rebuilt by evidence, and evidence starts small."),
                ]
            case .overwhelm:
                return [
                    ResetStep(seconds: 20, title: "Stop adding", text: "Long exhale. Nothing new gets added for sixty seconds — no tabs, no messages, no mental list-growing."),
                    ResetStep(seconds: 20, title: "Triage like an operator", text: "Of everything on the pile: what actually must happen today? Usually it's two things, not nine. Name the two."),
                    ResetStep(seconds: 20, title: "Serial, not parallel", text: "Pick the first of the two. Everything else formally waits. One thing at a time is not slower — it's how anything ships."),
                ]
            case .anxiety:
                return [
                    ResetStep(seconds: 20, title: "Slow the system", text: "Physiological sigh: two quick inhales through the nose, one long sigh out. Twice more. It's the fastest known downshift."),
                    ResetStep(seconds: 20, title: "Separate fact from forecast", text: "Anxiety trades in forecasts. What is actually true right now, versus what your mind is projecting? Say the facts only."),
                    ResetStep(seconds: 20, title: "Prepare, don't ruminate", text: "If the worry has an action — a check, a prep note, an ask — name it and schedule it. If it has none, it's weather. Let it pass."),
                ]
            }
        }
    }

    struct ResetStep {
        let seconds: Int
        let title: String
        let text: String
    }

    @State private var chosen: HotState?
    @State private var stepIndex = 0
    @State private var remaining = 0
    @State private var finished = false
    @State private var timer: Timer?

    var body: some View {
        NavigationStack {
            Group {
                if finished {
                    doneScreen
                } else if let hot = chosen {
                    stepScreen(hot)
                } else {
                    picker
                }
            }
            .screenBackground()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        timer?.invalidate()
                        dismiss()
                    }
                }
            }
        }
    }

    private var picker: some View {
        VStack(spacing: 14) {
            Spacer()
            Text("What's here right now?")
                .font(.system(.title2, design: .serif, weight: .semibold))
            Text("No judgement. Pick the closest one.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom, 12)
            ForEach(HotState.allCases) { hot in
                Button {
                    start(hot)
                } label: {
                    HStack {
                        Image(systemName: hot.symbol)
                            .frame(width: 30)
                            .foregroundStyle(Theme.ember)
                        Text(hot.rawValue)
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.tertiary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .cardStyle()
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding(.horizontal)
    }

    private func stepScreen(_ hot: HotState) -> some View {
        let steps = hot.steps
        let step = steps[stepIndex]
        return VStack(spacing: 24) {
            Spacer()
            Text("Step \(stepIndex + 1) of \(steps.count)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.15), lineWidth: 8)
                Circle()
                    .trim(from: 0, to: CGFloat(step.seconds - remaining) / CGFloat(step.seconds))
                    .stroke(Theme.teal, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: remaining)
                Text("\(remaining)")
                    .font(.system(size: 40, weight: .light, design: .rounded))
                    .monospacedDigit()
            }
            .frame(width: 130, height: 130)
            Text(step.title)
                .font(.system(.title3, design: .serif, weight: .semibold))
            Text(step.text)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 28)
                .frame(minHeight: 120, alignment: .top)
            Spacer()
            Button(stepIndex + 1 < steps.count ? "Next step" : "Done") {
                advance(hot)
            }
            .buttonStyle(.bordered)
            .padding(.bottom, 30)
        }
    }

    private var doneScreen: some View {
        VStack(spacing: 18) {
            Spacer()
            Image(systemName: "checkmark.circle")
                .font(.system(size: 54, weight: .light))
                .foregroundStyle(Theme.moss)
            Text("Wave ridden.")
                .font(.system(.title2, design: .serif, weight: .semibold))
            Text("Whatever you do next, you're choosing it now — not the surge. That's the whole skill.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Button("Back to it") { dismiss() }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 30)
        }
    }

    private func start(_ hot: HotState) {
        chosen = hot
        stepIndex = 0
        remaining = hot.steps[0].seconds
        Haptics.soft()
        runTimer(hot)
    }

    private func runTimer(_ hot: HotState) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            Task { @MainActor in
                if remaining > 1 {
                    remaining -= 1
                } else {
                    advance(hot)
                }
            }
        }
    }

    private func advance(_ hot: HotState) {
        Haptics.soft()
        if stepIndex + 1 < hot.steps.count {
            stepIndex += 1
            remaining = hot.steps[stepIndex].seconds
            runTimer(hot)
        } else {
            timer?.invalidate()
            finished = true
            state.resetCount += 1
            state.addCalmSeconds(hot.steps.map(\.seconds).reduce(0, +))
            Haptics.success()
        }
    }
}
