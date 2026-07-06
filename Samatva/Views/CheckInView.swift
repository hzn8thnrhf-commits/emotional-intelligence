import SwiftUI

struct CheckInView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var mood: Double = 3
    @State private var emotions: Set<EmotionTag> = []
    @State private var contexts: Set<ContextTag> = []
    @State private var note = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("How's the weather in there?")
                            .font(.system(.title3, design: .serif, weight: .semibold))
                        HStack {
                            Image(systemName: CheckIn.moodSymbol(Int(mood)))
                                .font(.system(size: 40))
                                .foregroundStyle(Theme.teal)
                                .frame(width: 56)
                                .contentTransition(.symbolEffect(.replace))
                            VStack(alignment: .leading) {
                                Text(CheckIn.moodLabel(Int(mood)))
                                    .font(.headline)
                                Slider(value: $mood, in: 1...5, step: 1)
                                    .onChange(of: mood) { Haptics.light() }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name it (optional, but it helps)")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                        FlowChips(items: EmotionTag.allCases, selection: $emotions) { $0.rawValue }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("What's it about?")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                        FlowChips(items: ContextTag.allCases, selection: $contexts) { $0.rawValue }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("A line for future you")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                        TextField("Optional note…", text: $note, axis: .vertical)
                            .lineLimit(2...4)
                            .padding(12)
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
            }
            .screenBackground()
            .navigationTitle("Check in")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        state.addCheckIn(CheckIn(
                            date: Date(),
                            mood: Int(mood),
                            emotions: Array(emotions),
                            contexts: Array(contexts),
                            note: note
                        ))
                        Haptics.success()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

// Simple wrapping chip selector.
struct FlowChips<Item: Identifiable & Hashable>: View {
    let items: [Item]
    @Binding var selection: Set<Item>
    let label: (Item) -> String

    var body: some View {
        FlexibleWrap(spacing: 8) {
            ForEach(items) { item in
                let isOn = selection.contains(item)
                Button {
                    if isOn { selection.remove(item) } else { selection.insert(item) }
                    Haptics.light()
                } label: {
                    Text(label(item))
                        .font(.subheadline)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(isOn ? Theme.teal : Color.gray.opacity(0.14),
                                    in: Capsule())
                        .foregroundStyle(isOn ? .white : .primary)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// Wrapping layout for chips.
struct FlexibleWrap: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? .infinity
        var x: CGFloat = 0, y: CGFloat = 0, rowHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > width, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        return CGSize(width: width, height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rowHeight: CGFloat = 0
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX, x > bounds.minX {
                x = bounds.minX
                y += rowHeight + spacing
                rowHeight = 0
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
