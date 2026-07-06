import SwiftUI
import Charts

struct ReflectView: View {
    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    statsRow
                    moodChart
                    if !state.insights.isEmpty {
                        insightsCard
                    }
                    milestonesCard
                    journalSection
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
            .screenBackground()
            .navigationTitle("Reflect")
        }
    }

    // MARK: - Stats

    private var statsRow: some View {
        HStack(spacing: 12) {
            stat(value: "\(state.calmMinutes)", label: "calm minutes", symbol: "wind")
            stat(value: "\(state.completedLessons.count)", label: "lessons done", symbol: "book")
            stat(value: "\(state.checkIns.count)", label: "check-ins", symbol: "cloud.sun")
        }
    }

    private func stat(value: String, label: String, symbol: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: symbol)
                .font(.callout)
                .foregroundStyle(Theme.teal)
            Text(value)
                .font(.system(.title2, design: .rounded, weight: .semibold))
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .cardStyle()
    }

    // MARK: - Mood chart

    private var recentCheckIns: [CheckIn] {
        state.checkIns.filter { $0.date > Date().addingTimeInterval(-14 * 86400) }
    }

    private var moodChart: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mood · last 14 days")
                .font(.subheadline.weight(.semibold))
            if recentCheckIns.isEmpty {
                Text("Check in for a few days and your weather pattern will appear here.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 24)
            } else {
                Chart(recentCheckIns) { checkIn in
                    PointMark(
                        x: .value("Day", checkIn.date, unit: .day),
                        y: .value("Mood", checkIn.mood)
                    )
                    .foregroundStyle(Theme.teal)
                    LineMark(
                        x: .value("Day", checkIn.date, unit: .day),
                        y: .value("Mood", checkIn.mood)
                    )
                    .foregroundStyle(Theme.teal.opacity(0.5))
                    .interpolationMethod(.catmullRom)
                }
                .chartYScale(domain: 0.5...5.5)
                .chartYAxis {
                    AxisMarks(values: [1, 3, 5]) { value in
                        AxisValueLabel {
                            if let mood = value.as(Int.self) {
                                Text(CheckIn.moodLabel(mood)).font(.caption2)
                            }
                        }
                    }
                }
                .frame(height: 160)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // MARK: - Insights

    private var insightsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Noticed", systemImage: "eye")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Theme.indigo)
            ForEach(state.insights, id: \.self) { insight in
                HStack(alignment: .top, spacing: 8) {
                    Text("·").fontWeight(.bold)
                    Text(insight).font(.subheadline)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // MARK: - Milestones

    private var milestonesCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label("Milestones", systemImage: "laurel.leading")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Theme.moss)
                Spacer()
                Text("\(state.earnedMilestones.count) of \(AppState.milestones.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)], spacing: 10) {
                ForEach(AppState.milestones) { milestone in
                    let earned = milestone.isEarned(state)
                    VStack(spacing: 6) {
                        Image(systemName: milestone.symbol)
                            .font(.title3)
                            .foregroundStyle(earned ? Theme.moss : .secondary.opacity(0.4))
                        Text(milestone.title)
                            .font(.caption2.weight(.medium))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(earned ? .primary : .secondary.opacity(0.6))
                        Text(milestone.detail)
                            .font(.system(size: 9))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.tertiary)
                    }
                    .frame(maxWidth: .infinity, minHeight: 84, alignment: .top)
                    .padding(8)
                    .background(
                        (earned ? Theme.moss.opacity(0.08) : Color.gray.opacity(0.05)),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    // MARK: - Journal

    private var journalSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Journal")
                .font(.subheadline.weight(.semibold))
            if state.journal.isEmpty {
                Text("Reflections, reframes and decompress notes will collect here — private, on this phone only.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(state.journal.prefix(20)) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Label(entry.kind.rawValue, systemImage: entry.kind.symbol)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(Theme.teal)
                            Spacer()
                            Text(entry.date, style: .date)
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                        if entry.kind == .reflection {
                            Text(entry.title)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Text(entry.body)
                            .font(.subheadline)
                            .lineLimit(6)
                    }
                    .padding(.vertical, 8)
                    Divider().opacity(0.4)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
