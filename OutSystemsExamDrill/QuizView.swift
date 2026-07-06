import SwiftUI

struct QuizView: View {
    @EnvironmentObject private var store: DrillStore
    let config: QuizConfig
    let onQuit: () -> Void
    let onFinish: (QuizResult) -> Void

    @State private var currentIndex = 0
    @State private var answers: [Int?]
    @State private var isRevealed = false
    @State private var remainingSeconds: Int
    @State private var didFinish = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(
        config: QuizConfig,
        onQuit: @escaping () -> Void,
        onFinish: @escaping (QuizResult) -> Void
    ) {
        self.config = config
        self.onQuit = onQuit
        self.onFinish = onFinish
        _answers = State(initialValue: Array(repeating: nil, count: config.items.count))
        _remainingSeconds = State(initialValue: config.durationSeconds ?? 0)
    }

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(
                title: config.title,
                backTitle: "中断",
                onBack: onQuit,
                trailing: AnyView(headerTrailing)
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    progressHeader

                    DrillCard {
                        VStack(alignment: .leading, spacing: 14) {
                            Text(item.question.prompt)
                                .font(.system(size: 17, weight: .black, design: .rounded))
                                .foregroundStyle(Color.drillInk)
                                .lineSpacing(4)
                                .fixedSize(horizontal: false, vertical: true)

                            VStack(spacing: 10) {
                                ForEach(item.optionOrder.indices, id: \.self) { position in
                                    QuizOptionButton(
                                        letter: optionLetter(for: position),
                                        text: item.optionText(at: position),
                                        state: optionState(for: position),
                                        action: {
                                            guard !isRevealed else { return }
                                            answers[currentIndex] = position
                                        }
                                    )
                                }
                            }

                            if isRevealed {
                                ExplanationView(
                                    isCorrect: answers[currentIndex] == item.correctPosition,
                                    explanation: item.question.explanation,
                                    source: item.question.source
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)
                .padding(.bottom, 18)
                .frame(maxWidth: 430)
                .frame(maxWidth: .infinity)
            }

            footer
        }
        .background(Color.drillShell)
        .onReceive(timer) { _ in
            guard config.mode == .mock, !didFinish else { return }
            guard remainingSeconds > 0 else {
                finish()
                return
            }
            remainingSeconds -= 1
            if remainingSeconds == 0 {
                finish()
            }
        }
    }

    private var item: QuizItem {
        config.items[currentIndex]
    }

    private var headerTrailing: some View {
        HStack(spacing: 8) {
            if config.mode == .mock {
                Text(timeText)
                    .font(.caption.monospaced().weight(.black))
                    .foregroundStyle(remainingSeconds <= 300 ? Color.drillDanger : Color.drillInk)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.white, in: Capsule())
                    .overlay {
                        Capsule()
                            .stroke(remainingSeconds <= 300 ? Color.drillDanger : Color.drillLineStrong, lineWidth: 1)
                    }
            }

            Button {
                store.toggleBookmark(questionID: item.question.id, examID: config.exam.id)
            } label: {
                Image(systemName: store.isBookmarked(questionID: item.question.id, examID: config.exam.id) ? "star.fill" : "star")
                    .font(.headline.weight(.black))
                    .foregroundStyle(store.isBookmarked(questionID: item.question.id, examID: config.exam.id) ? Color.drillGold : Color.drillSubtext)
                    .frame(width: 34, height: 34)
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(store.isBookmarked(questionID: item.question.id, examID: config.exam.id) ? Color.drillGold : Color.drillLineStrong, lineWidth: 1.5)
                    }
            }
            .buttonStyle(.plain)
        }
    }

    private var progressHeader: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Badge(text: config.exam.domain(for: item.question.domain).shortName, color: config.exam.tint)
                ProgressView(value: Double(currentIndex), total: Double(config.items.count))
                    .tint(config.exam.tint)
                Text("\(currentIndex + 1) / \(config.items.count)")
                    .font(.caption.monospaced().weight(.bold))
                    .foregroundStyle(Color.drillSubtext)
                    .frame(minWidth: 54, alignment: .trailing)
            }
        }
    }

    private var footer: some View {
        VStack {
            PrimaryActionButton(
                title: primaryButtonTitle,
                tint: config.mode == .mock ? Color.drillBrand : config.exam.tint,
                isDisabled: answers[currentIndex] == nil,
                action: handlePrimaryAction
            )
        }
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 16)
        .frame(maxWidth: 430)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.drillLine)
                .frame(height: 1)
        }
    }

    private var primaryButtonTitle: String {
        if config.mode == .mock {
            return currentIndex == config.items.count - 1 ? "提出して採点" : "次へ"
        }
        if isRevealed {
            return currentIndex == config.items.count - 1 ? "結果を見る" : "次の問題へ"
        }
        return "解答する"
    }

    private var timeText: String {
        let minutes = max(remainingSeconds, 0) / 60
        let seconds = max(remainingSeconds, 0) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func handlePrimaryAction() {
        guard answers[currentIndex] != nil else { return }

        if config.mode == .mock {
            moveNextOrFinish()
            return
        }

        if isRevealed {
            moveNextOrFinish()
        } else {
            revealCurrentAnswer()
        }
    }

    private func revealCurrentAnswer() {
        guard let answer = answers[currentIndex] else { return }
        isRevealed = true
        store.markAnswered(
            questionID: item.question.id,
            examID: config.exam.id,
            isCorrect: answer == item.correctPosition
        )
    }

    private func moveNextOrFinish() {
        if currentIndex < config.items.count - 1 {
            currentIndex += 1
            isRevealed = false
        } else {
            finish()
        }
    }

    private func finish() {
        guard !didFinish else { return }
        didFinish = true

        var correct = 0
        var outcomes: [AnswerOutcome] = []
        var byDomain: [Int: (correct: Int, total: Int)] = [:]

        for index in config.items.indices {
            let item = config.items[index]
            let isCorrect = answers[index] == item.correctPosition
            if isCorrect {
                correct += 1
            }

            let current = byDomain[item.question.domain] ?? (correct: 0, total: 0)
            byDomain[item.question.domain] = (
                correct: current.correct + (isCorrect ? 1 : 0),
                total: current.total + 1
            )

            outcomes.append(
                AnswerOutcome(
                    questionID: item.question.id,
                    domain: item.question.domain,
                    isCorrect: isCorrect
                )
            )

            if config.mode == .mock {
                store.markAnswered(
                    questionID: item.question.id,
                    examID: config.exam.id,
                    isCorrect: isCorrect
                )
            }
        }

        let domainScores = config.exam.domains.compactMap { domain -> DomainScoreResult? in
            guard let score = byDomain[domain.id], score.total > 0 else { return nil }
            return DomainScoreResult(
                domainID: domain.id,
                domainName: domain.name,
                correct: score.correct,
                total: score.total
            )
        }

        let result = QuizResult(
            exam: config.exam,
            mode: config.mode,
            correct: correct,
            total: config.items.count,
            domainScores: domainScores,
            outcomes: outcomes,
            completedAt: Date()
        )
        store.record(result: result)
        onFinish(result)
    }

    private func optionState(for position: Int) -> QuizOptionButton.StateKind {
        if isRevealed {
            if position == item.correctPosition {
                return .correct
            }
            if answers[currentIndex] == position {
                return .wrong
            }
        }

        if answers[currentIndex] == position {
            return .selected
        }

        return .normal
    }

    private func optionLetter(for position: Int) -> String {
        ["A", "B", "C", "D"][position]
    }
}

private struct QuizOptionButton: View {
    enum StateKind {
        case normal
        case selected
        case correct
        case wrong
    }

    let letter: String
    let text: String
    let state: StateKind
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 12) {
                Text(letter)
                    .font(.caption.monospaced().weight(.black))
                    .foregroundStyle(markerForeground)
                    .frame(width: 24, height: 24)
                    .background(markerBackground, in: RoundedRectangle(cornerRadius: 7, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                            .stroke(markerBorder, lineWidth: 1.5)
                    }

                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(Color.drillInk)
                    .fixedSize(horizontal: false, vertical: true)

                Spacer(minLength: 0)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(background, in: RoundedRectangle(cornerRadius: 13, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .stroke(border, lineWidth: 1.5)
            }
        }
        .buttonStyle(.plain)
    }

    private var background: Color {
        switch state {
        case .normal:
            return .white
        case .selected:
            return Color(hex: "#F0F5F9")
        case .correct:
            return Color(hex: "#EEF7F1")
        case .wrong:
            return Color(hex: "#FBEFEC")
        }
    }

    private var border: Color {
        switch state {
        case .normal:
            return Color.drillLineStrong
        case .selected:
            return Color.drillBrand
        case .correct:
            return Color.drillSuccess
        case .wrong:
            return Color.drillDanger
        }
    }

    private var markerBackground: Color {
        state == .normal ? Color.white : border
    }

    private var markerBorder: Color {
        state == .normal ? Color.drillLineStrong : border
    }

    private var markerForeground: Color {
        state == .normal ? Color.drillSubtext : .white
    }
}

private struct ExplanationView: View {
    let isCorrect: Bool
    let explanation: String
    let source: String

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Divider()
                .overlay(Color.drillLineStrong)
            Text(isCorrect ? "正解！" : "不正解")
                .font(.subheadline.weight(.black))
                .foregroundStyle(isCorrect ? Color.drillSuccess : Color.drillDanger)
            Text(explanation)
                .font(.subheadline)
                .foregroundStyle(Color(hex: "#3B4856"))
                .fixedSize(horizontal: false, vertical: true)
            Text("【出典】\(source)")
                .font(.caption2)
                .foregroundStyle(Color.drillSubtext)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 4)
    }
}
