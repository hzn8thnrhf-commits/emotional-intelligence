import SwiftUI

struct LearnView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(ContentLibrary.courses) { course in
                        NavigationLink {
                            CourseView(course: course)
                        } label: {
                            CourseCard(course: course, progress: state.progress(for: course))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .screenBackground()
            .navigationTitle("Learn")
        }
    }
}

struct CourseCard: View {
    let course: Course
    let progress: Double

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(course.tint.opacity(0.2), lineWidth: 5)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(course.tint, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Image(systemName: course.symbol)
                    .font(.title3)
                    .foregroundStyle(course.tint)
            }
            .frame(width: 54, height: 54)

            VStack(alignment: .leading, spacing: 3) {
                Text(course.title)
                    .font(.headline)
                Text(course.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(progress >= 1 ? "Complete" : "\(Int(progress * 100))% · \(course.lessons.count) lessons")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.tertiary)
        }
        .cardStyle()
    }
}

struct CourseView: View {
    @EnvironmentObject private var state: AppState
    let course: Course

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(course.subtitle)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 4)
                ForEach(Array(course.lessons.enumerated()), id: \.element.id) { index, lesson in
                    NavigationLink {
                        LessonView(course: course, lesson: lesson)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: state.completedLessons.contains(lesson.id)
                                  ? "checkmark.circle.fill" : "\(index + 1).circle")
                                .font(.title3)
                                .foregroundStyle(state.completedLessons.contains(lesson.id)
                                                 ? course.tint : .secondary)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(lesson.title)
                                    .font(.subheadline.weight(.medium))
                                    .multilineTextAlignment(.leading)
                                Text("\(lesson.minutes) min\(lesson.scenario != nil ? " · includes scenario" : "")")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                        .cardStyle()
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .screenBackground()
        .navigationTitle(course.title)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct LessonView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss
    let course: Course
    let lesson: Lesson

    @State private var reflectionText = ""
    @State private var reflectionSaved = false

    private var isComplete: Bool { state.completedLessons.contains(lesson.id) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("\(course.title) · \(lesson.minutes) min")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(course.tint)
                    .textCase(.uppercase)

                ForEach(lesson.sections) { section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.heading)
                            .font(.system(.headline, design: .serif))
                        Text(section.body)
                            .font(.body)
                            .lineSpacing(4)
                            .foregroundStyle(.primary.opacity(0.85))
                    }
                    .cardStyle()
                }

                VStack(alignment: .leading, spacing: 10) {
                    Label("Keep", systemImage: "bookmark")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(course.tint)
                    ForEach(lesson.takeaways, id: \.self) { takeaway in
                        HStack(alignment: .top, spacing: 8) {
                            Text("·").fontWeight(.bold)
                            Text(takeaway).font(.callout)
                        }
                    }
                }
                .cardStyle()

                if let scenario = lesson.scenario {
                    ScenarioCard(scenario: scenario, tint: course.tint)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Label("Reflect", systemImage: "pencil.line")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(course.tint)
                    Text(lesson.reflection)
                        .font(.callout)
                        .italic()
                    TextField("A sentence is plenty…", text: $reflectionText, axis: .vertical)
                        .lineLimit(2...5)
                        .padding(12)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    if reflectionSaved {
                        Label("Saved to your journal", systemImage: "checkmark")
                            .font(.caption)
                            .foregroundStyle(Theme.moss)
                    } else if !reflectionText.trimmingCharacters(in: .whitespaces).isEmpty {
                        Button("Save reflection") {
                            state.addJournal(JournalEntry(
                                date: Date(),
                                kind: .reflection,
                                title: lesson.title,
                                body: reflectionText
                            ))
                            reflectionSaved = true
                            Haptics.success()
                        }
                        .font(.subheadline.weight(.medium))
                    }
                }
                .cardStyle()

                Button {
                    if !isComplete {
                        state.completeLesson(lesson.id)
                        Haptics.success()
                    }
                    dismiss()
                } label: {
                    Label(isComplete ? "Completed" : "Mark as complete",
                          systemImage: isComplete ? "checkmark.circle.fill" : "circle")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(course.tint)
                .disabled(isComplete)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .screenBackground()
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScenarioCard: View {
    let scenario: Scenario
    let tint: Color
    @State private var picked: ScenarioOption?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Scenario", systemImage: "theatermasks")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(tint)
            Text(scenario.prompt)
                .font(.callout)
                .lineSpacing(3)

            ForEach(scenario.options) { option in
                Button {
                    withAnimation(.snappy) { picked = option }
                    Haptics.light()
                } label: {
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: iconFor(option))
                            .foregroundStyle(colorFor(option))
                            .padding(.top, 2)
                        Text(option.text)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.primary)
                        Spacer(minLength: 0)
                    }
                    .padding(12)
                    .background(backgroundFor(option), in: RoundedRectangle(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .disabled(picked != nil)
            }

            if let picked {
                VStack(alignment: .leading, spacing: 6) {
                    Text(picked.isBest ? "Well read." : "A common instinct —")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(picked.isBest ? Theme.moss : Theme.ember)
                    Text(picked.feedback)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    if !picked.isBest, let best = scenario.options.first(where: \.isBest) {
                        Text("Stronger move: \(best.text)")
                            .font(.subheadline)
                            .padding(.top, 4)
                    }
                    Button("Try again") {
                        withAnimation(.snappy) { self.picked = nil }
                    }
                    .font(.caption.weight(.medium))
                    .padding(.top, 4)
                }
                .padding(.top, 4)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }
        }
        .cardStyle()
    }

    private func iconFor(_ option: ScenarioOption) -> String {
        guard picked?.id == option.id else { return "circle" }
        return option.isBest ? "checkmark.circle.fill" : "exclamationmark.circle.fill"
    }

    private func colorFor(_ option: ScenarioOption) -> Color {
        guard picked?.id == option.id else { return .secondary }
        return option.isBest ? Theme.moss : Theme.ember
    }

    private func backgroundFor(_ option: ScenarioOption) -> Color {
        guard picked?.id == option.id else { return Color.gray.opacity(0.08) }
        return (option.isBest ? Theme.moss : Theme.ember).opacity(0.12)
    }
}
