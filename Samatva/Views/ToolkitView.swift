import SwiftUI

struct ToolkitView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    sectionLabel("In the moment")
                    ToolRow(symbol: "wind", tint: Theme.teal,
                            title: "Breathe",
                            subtitle: "Box, physiological sigh, 4-7-8, coherent") {
                        BreathingView(pattern: .box)
                    }
                    ToolRow(symbol: "hand.raised", tint: Theme.indigo,
                            title: "Ground: 5-4-3-2-1",
                            subtitle: "Out of your head, back into the room") {
                        GroundingView()
                    }

                    sectionLabel("Work it through")
                    ToolRow(symbol: "arrow.triangle.2.circlepath", tint: Theme.ember,
                            title: "Reframe a thought",
                            subtitle: "Catch the story, question it, rewrite it") {
                        ReframeView()
                    }
                    ToolRow(symbol: "moon.stars", tint: Theme.plum,
                            title: "Decompress",
                            subtitle: "Close the day so it doesn't follow you home") {
                        DecompressView()
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .screenBackground()
            .navigationTitle("Toolkit")
        }
    }

    private func sectionLabel(_ text: String) -> some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .foregroundStyle(.secondary)
            .textCase(.uppercase)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 6)
    }
}

struct ToolRow<Destination: View>: View {
    let symbol: String
    let tint: Color
    let title: String
    let subtitle: String
    @ViewBuilder let destination: () -> Destination

    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HStack(spacing: 14) {
                Image(systemName: symbol)
                    .font(.title3)
                    .foregroundStyle(tint)
                    .frame(width: 36)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
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

// MARK: - Grounding

struct GroundingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var step = 0

    private let steps: [(Int, String, String)] = [
        (5, "things you can see", "Look around slowly. The mug, the window, the grain of the desk. Name them silently, one by one."),
        (4, "things you can touch", "The chair under you, fabric on your arm, the cool of the phone, your feet in your shoes."),
        (3, "things you can hear", "The hum of the building, traffic, your own breath. Just notice — no fixing."),
        (2, "things you can smell", "Coffee, air, paper. If nothing comes, take one slow breath through the nose."),
        (1, "thing you can taste", "Or simply notice your mouth and jaw, and let the jaw unclench."),
    ]

    var body: some View {
        VStack(spacing: 28) {
            Spacer()
            if step < steps.count {
                let current = steps[step]
                Text("\(current.0)")
                    .font(.system(size: 88, weight: .ultraLight, design: .rounded))
                    .foregroundStyle(Theme.indigo)
                    .contentTransition(.numericText())
                Text(current.1)
                    .font(.system(.title3, design: .serif, weight: .semibold))
                Text(current.2)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 36)
                Spacer()
                Button(step == steps.count - 1 ? "Done" : "Next") {
                    withAnimation(.snappy) { step += 1 }
                    Haptics.light()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 30)
            } else {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 54, weight: .light))
                    .foregroundStyle(Theme.moss)
                Text("Back in the room.")
                    .font(.system(.title2, design: .serif, weight: .semibold))
                Spacer()
                Button("Close") { dismiss() }
                    .buttonStyle(.bordered)
                    .padding(.bottom, 30)
            }
        }
        .screenBackground()
        .navigationTitle("Ground")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Reframe

struct ReframeView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var thought = ""
    @State private var distortions: Set<String> = []
    @State private var balanced = ""
    @State private var saved = false

    private let distortionList: [(String, String)] = [
        ("Mind reading", "\u{201C}He thinks I'm not up to it\u{201D} — you don't actually know."),
        ("Catastrophising", "One miss becomes a ruined career by step three."),
        ("All-or-nothing", "Anything short of perfect counts as failure."),
        ("Personalising", "Someone's mood or a market move becomes your fault."),
        ("Should-storms", "\u{201C}I should handle this alone / should be further ahead by now.\u{201D}"),
        ("Discounting wins", "Successes were luck; only the misses were real."),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 8) {
                    stepHeader(1, "Catch the thought")
                    Text("Write the sentence your mind is repeating, verbatim.")
                        .font(.subheadline).foregroundStyle(.secondary)
                    TextField("e.g. \u{201C}If this deal slips, I've failed the whole team\u{201D}", text: $thought, axis: .vertical)
                        .lineLimit(2...4)
                        .padding(12)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }

                VStack(alignment: .leading, spacing: 8) {
                    stepHeader(2, "Spot the distortion")
                    Text("Which patterns is it running? (Pick any that fit.)")
                        .font(.subheadline).foregroundStyle(.secondary)
                    ForEach(distortionList, id: \.0) { item in
                        let isOn = distortions.contains(item.0)
                        Button {
                            if isOn { distortions.remove(item.0) } else { distortions.insert(item.0) }
                            Haptics.light()
                        } label: {
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(isOn ? Theme.ember : .secondary)
                                    .padding(.top, 2)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.0).font(.subheadline.weight(.medium))
                                    Text(item.1).font(.caption).foregroundStyle(.secondary)
                                }
                                Spacer(minLength: 0)
                            }
                            .padding(10)
                            .background(isOn ? Theme.ember.opacity(0.1) : Color.gray.opacity(0.07),
                                        in: RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    stepHeader(3, "Write the balanced version")
                    Text("Not fake positivity — what a fair-minded colleague who knows all the facts would say.")
                        .font(.subheadline).foregroundStyle(.secondary)
                    TextField("e.g. \u{201C}The timeline slipped for reasons beyond me; my part is on track and I've flagged the risk early\u{201D}", text: $balanced, axis: .vertical)
                        .lineLimit(2...5)
                        .padding(12)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }

                Button {
                    let body = "Thought: \(thought)\nPatterns: \(distortions.sorted().joined(separator: ", "))\nBalanced: \(balanced)"
                    state.addJournal(JournalEntry(date: Date(), kind: .reframe, title: "Reframe", body: body))
                    state.reframeCount += 1
                    state.save()
                    saved = true
                    Haptics.success()
                    dismiss()
                } label: {
                    Text("Save reframe")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .disabled(thought.trimmingCharacters(in: .whitespaces).isEmpty ||
                          balanced.trimmingCharacters(in: .whitespaces).isEmpty)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Reframe")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func stepHeader(_ number: Int, _ title: String) -> some View {
        Label(title, systemImage: "\(number).circle.fill")
            .font(.headline)
            .foregroundStyle(Theme.teal)
    }
}

// MARK: - Decompress

struct DecompressView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var hardest = ""
    @State private var handled = ""
    @State private var tomorrow = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("Three questions to close the day. Your brain files the day by its ending — give it a clean one.")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                promptField("What was the hardest moment today?",
                            "Name it plainly. Naming closes loops.", $hardest)
                promptField("What did you handle better than you would have a year ago?",
                            "There's always one. It counts.", $handled)
                promptField("What's tomorrow's first move?",
                            "One concrete thing. Then the desk is closed.", $tomorrow)

                Button {
                    let body = "Hardest: \(hardest)\nHandled well: \(handled)\nTomorrow's first move: \(tomorrow)"
                    state.addJournal(JournalEntry(date: Date(), kind: .decompress, title: "Day closed", body: body))
                    Haptics.success()
                    dismiss()
                } label: {
                    Text("Shutdown complete")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(Theme.plum)
                .disabled([hardest, handled, tomorrow].allSatisfy {
                    $0.trimmingCharacters(in: .whitespaces).isEmpty
                })
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Decompress")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func promptField(_ prompt: String, _ hint: String, _ text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(prompt)
                .font(.system(.headline, design: .serif))
            Text(hint)
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField("…", text: text, axis: .vertical)
                .lineLimit(2...4)
                .padding(12)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }
}
