import SwiftUI

enum ScreenshotTarget: String {
    case home
    case mode
    case quiz
    case result
    case learning

    static var current: ScreenshotTarget? {
        guard let rawValue = ProcessInfo.processInfo.environment["OUTSYSTEMS_SCREENSHOT_TARGET"] else {
            return nil
        }
        return ScreenshotTarget(rawValue: rawValue)
    }
}

struct ScreenshotPreviewView: View {
    let target: ScreenshotTarget

    var body: some View {
        switch target {
        case .home:
            HomeView { _ in }
        case .mode:
            ModeView(exam: screenshotExam, onBack: {}, onStart: { _, _ in })
        case .quiz:
            QuizView(config: screenshotQuizConfig, onQuit: {}, onFinish: { _ in })
        case .result:
            ResultView(result: screenshotResult, onReviewWrong: {}, onHome: {})
        case .learning:
            ScreenshotLearningDetailView(module: screenshotModule)
        }
    }
}

private var screenshotExam: ExamDefinition {
    ExamCatalog.exams.first ?? ExamCatalog.exams[0]
}

private var screenshotItems: [QuizItem] {
    Array(screenshotExam.questions.prefix(8)).map { question in
        QuizItem(question: question, optionOrder: Array(question.options.indices))
    }
}

private var screenshotQuizConfig: QuizConfig {
    QuizConfig(
        exam: screenshotExam,
        mode: .practice,
        items: screenshotItems,
        durationSeconds: nil
    )
}

private var screenshotResult: QuizResult {
    let questions = Array(screenshotExam.questions.prefix(20))
    let outcomes = questions.enumerated().map { index, question in
        AnswerOutcome(
            questionID: question.id,
            domain: question.domain,
            isCorrect: index < 16
        )
    }
    let domainScores = Array(screenshotExam.domains.prefix(4)).enumerated().map { index, domain in
        DomainScoreResult(
            domainID: domain.id,
            domainName: domain.name,
            correct: [4, 4, 5, 3][index],
            total: 5
        )
    }

    return QuizResult(
        exam: screenshotExam,
        mode: .mock,
        correct: 16,
        total: 20,
        domainScores: domainScores,
        outcomes: outcomes,
        completedAt: Date()
    )
}

private var screenshotModule: LearningModule {
    LearningCatalog.guides.first?.modules.first ?? LearningCatalog.modules[0]
}

private struct ScreenshotLearningDetailView: View {
    let module: LearningModule

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: "教材", backTitle: "一覧", onBack: {})

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 8) {
                        Badge(text: module.domainLabel, color: module.tint)
                        Text(module.title)
                            .font(.system(size: 25, weight: .black, design: .rounded))
                            .foregroundStyle(Color.drillInk)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(module.subtitle)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.drillSubtext)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(module.keyFacts.prefix(4)) { fact in
                            DrillCard {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(fact.label)
                                        .font(.caption2.monospaced().weight(.black))
                                        .foregroundStyle(Color.drillSubtext)
                                    Text(fact.value)
                                        .font(.title3.weight(.black))
                                        .foregroundStyle(module.tint)
                                    Text(fact.note)
                                        .font(.caption2.weight(.semibold))
                                        .foregroundStyle(Color.drillSubtext)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }

                    DrillCard(accent: module.tint) {
                        VStack(alignment: .leading, spacing: 9) {
                            Text("試験前に押さえる要点")
                                .font(.subheadline.weight(.black))
                                .foregroundStyle(Color.drillInk)
                            ForEach(module.highlights.prefix(4), id: \.self) { highlight in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(module.tint)
                                    Text(highlight)
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(Color.drillSubtext)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }

                    ForEach(module.sections.prefix(2)) { section in
                        DrillCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(section.title)
                                    .font(.headline.weight(.black))
                                    .foregroundStyle(Color.drillInk)
                                Text(section.summary)
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(Color.drillSubtext)
                                    .fixedSize(horizontal: false, vertical: true)
                                ForEach(section.bullets.prefix(3), id: \.self) { bullet in
                                    HStack(alignment: .top, spacing: 8) {
                                        Circle()
                                            .fill(module.tint)
                                            .frame(width: 6, height: 6)
                                            .padding(.top, 6)
                                        Text(bullet)
                                            .font(.caption)
                                            .foregroundStyle(Color.drillInk)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
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
