import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: DrillStore
    let onSelect: (ExamDefinition) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                hero

                ForEach(ExamCatalog.exams) { exam in
                    ExamCard(
                        exam: exam,
                        rate: store.examRate(for: exam.id),
                        onSelect: {
                            onSelect(exam)
                        }
                    )
                }

                ForEach(ExamCatalog.upcomingExams) { exam in
                    UpcomingExamCard(exam: exam)
                }

                Text("※ 本アプリの問題は公式サンプル試験のスタイルを参考にした自作の予想問題です。")
                    .font(.caption2)
                    .foregroundStyle(Color.drillSubtext)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 4)
            }
            .padding(.horizontal, 18)
            .padding(.top, 26)
            .padding(.bottom, 28)
            .frame(maxWidth: 430)
            .frame(maxWidth: .infinity)
        }
        .background(Color.drillShell)
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("OutSystems Certification Drill")
                .font(.caption.monospaced().weight(.semibold))
                .foregroundStyle(Color.drillSubtext)
            Text("OS資格ドリル")
                .font(.system(size: 28, weight: .black, design: .rounded))
                .foregroundStyle(Color.drillInk)
            (
                Text("スキマ時間で、")
                    .foregroundStyle(Color.drillSubtext)
                + Text("合格ライン")
                    .foregroundStyle(Color.drillODC)
                    .fontWeight(.black)
                + Text("まで。")
                    .foregroundStyle(Color.drillSubtext)
            )
            .font(.subheadline.weight(.semibold))
            Text("問題演習と教材復習で、今日の対策を始めましょう。")
                .font(.caption)
                .foregroundStyle(Color.drillSubtext)
        }
        .padding(.bottom, 2)
    }
}

private struct ExamCard: View {
    let exam: ExamDefinition
    let rate: Int?
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            DrillCard(accent: exam.tint) {
                HStack(alignment: .top, spacing: 14) {
                    VStack(alignment: .leading, spacing: 9) {
                        Badge(text: exam.shortName, color: exam.tint)

                        Text(exam.name)
                            .font(.headline.weight(.black))
                            .foregroundStyle(Color.drillInk)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(exam.description)
                            .font(.caption)
                            .foregroundStyle(Color.drillSubtext)
                            .fixedSize(horizontal: false, vertical: true)

                        HStack(spacing: 14) {
                            Label("収録 \(exam.questions.count)問", systemImage: "list.bullet.rectangle")
                            Label("模試 \(exam.mockQuestionCount)問/\(exam.mockMinutes)分", systemImage: "timer")
                        }
                        .font(.caption2.monospaced())
                        .foregroundStyle(Color.drillSubtext)
                    }

                    Spacer(minLength: 8)

                    ProgressRing(percent: rate, color: exam.tint)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

private struct UpcomingExamCard: View {
    let exam: UpcomingExam

    var body: some View {
        DrillCard(accent: Color(hex: "#9AA7B4")) {
            VStack(alignment: .leading, spacing: 9) {
                HStack(spacing: 7) {
                    Badge(text: exam.shortName, color: Color(hex: "#9AA7B4"))
                    Badge(text: "準備中", color: Color(hex: "#EDEFF2"), foreground: Color.drillSubtext)
                }

                Text(exam.name)
                    .font(.headline.weight(.black))
                    .foregroundStyle(Color.drillInk)

                Text(exam.description)
                    .font(.caption)
                    .foregroundStyle(Color.drillSubtext)
            }
        }
        .opacity(0.62)
    }
}
