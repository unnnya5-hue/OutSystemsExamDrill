import SwiftUI

struct ResultView: View {
    let result: QuizResult
    let onReviewWrong: () -> Void
    let onHome: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: result.mode.resultTitle)

            ScrollView {
                VStack(spacing: 14) {
                    resultHero

                    ForEach(result.domainScores) { score in
                        DomainBreakdownCard(score: score, tint: result.exam.tint)
                    }

                    VStack(spacing: 10) {
                        if !result.wrongQuestionIDs.isEmpty {
                            PrimaryActionButton(
                                title: "間違えた \(result.wrongQuestionIDs.count) 問を復習する",
                                tint: result.exam.tint,
                                action: onReviewWrong
                            )
                        }
                        PrimaryActionButton(
                            title: "ホームへ戻る",
                            tint: Color.drillBrand,
                            isGhost: true,
                            action: onHome
                        )
                    }
                    .padding(.top, 2)
                }
                .padding(.horizontal, 18)
                .padding(.top, 26)
                .padding(.bottom, 32)
                .frame(maxWidth: 430)
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.drillShell)
    }

    private var resultHero: some View {
        VStack(spacing: 8) {
            Text(verdictText)
                .font(.system(size: 30, weight: .black, design: .rounded))
                .foregroundStyle(verdictColor)
                .multilineTextAlignment(.center)

            HStack(spacing: 6) {
                Text("\(result.correct) / \(result.total)")
                    .font(.title3.monospaced().weight(.black))
                    .foregroundStyle(Color.drillInk)
                Text("正解（\(result.percent)%）")
                    .font(.subheadline)
                    .foregroundStyle(Color.drillSubtext)
            }

            if result.mode == .mock {
                Text("合格基準 \(result.exam.passRate)%")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.drillSubtext)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 6)
    }

    private var verdictText: String {
        if result.mode == .mock {
            return result.passed ? "合格ライン到達" : "もう一歩"
        }
        return "おつかれさまでした"
    }

    private var verdictColor: Color {
        if result.mode == .mock {
            return result.passed ? Color.drillSuccess : Color.drillDanger
        }
        return Color.drillBrand
    }
}

private struct DomainBreakdownCard: View {
    let score: DomainScoreResult
    let tint: Color

    var body: some View {
        DrillCard {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(score.domainName)
                        .font(.subheadline.weight(.black))
                        .foregroundStyle(Color.drillInk)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer(minLength: 8)
                    Text("\(score.correct)/\(score.total)（\(score.percent)%）")
                        .font(.caption.monospaced().weight(.black))
                        .foregroundStyle(Color.drillInk)
                }

                ProgressView(value: Double(score.percent), total: 100)
                    .tint(tint)
            }
        }
    }
}
