import SwiftUI

struct StatsView: View {
    @EnvironmentObject private var store: DrillStore

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: "成績")

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        MetricCard(
                            value: "\(store.totalAnswered)",
                            label: "解答した問題数",
                            symbol: "checklist"
                        )
                        MetricCard(
                            value: store.correctRate.map { "\($0)%" } ?? "-%",
                            label: "通算正答率",
                            symbol: "percent"
                        )
                    }

                    Text("セッション履歴")
                        .font(.caption.monospaced().weight(.semibold))
                        .foregroundStyle(Color.drillSubtext)
                        .padding(.top, 6)

                    if store.sessions.isEmpty {
                        DrillCard {
                            VStack(spacing: 8) {
                                Image(systemName: "chart.bar.doc.horizontal")
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(Color.drillSubtext)
                                Text("まだ記録がありません")
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(Color.drillInk)
                                Text("ホームから学習を始めると、ここに履歴が残ります。")
                                    .font(.caption)
                                    .foregroundStyle(Color.drillSubtext)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                        }
                    } else {
                        ForEach(store.sessions.prefix(12)) { session in
                            SessionHistoryRow(session: session)
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 32)
                .frame(maxWidth: 430)
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.drillShell)
    }
}

private struct SessionHistoryRow: View {
    let session: SessionRecord

    var body: some View {
        DrillCard {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(session.examShortName) \(session.mode.label)")
                        .font(.subheadline.weight(.black))
                        .foregroundStyle(Color.drillInk)
                    Text(session.completedAt.drillHistoryTime)
                        .font(.caption.monospaced())
                        .foregroundStyle(Color.drillSubtext)
                }

                Spacer(minLength: 8)

                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(session.correct)/\(session.total)")
                        .font(.headline.monospaced().weight(.black))
                        .foregroundStyle(session.percent >= 70 ? Color.drillSuccess : Color.drillDanger)
                    Text("\(session.percent)%")
                        .font(.caption2.monospaced().weight(.bold))
                        .foregroundStyle(Color.drillSubtext)
                }
            }
        }
    }
}
