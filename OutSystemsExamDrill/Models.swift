import Foundation
import SwiftUI

struct ExamDefinition: Identifiable {
    let id: String
    let name: String
    let shortName: String
    let description: String
    let colorHex: String
    let passRate: Int
    let mockQuestionCount: Int
    let mockMinutes: Int
    let domains: [DomainDefinition]
    let mockMix: [Int: Int]
    let questions: [DrillQuestion]

    var tint: Color {
        Color(hex: colorHex)
    }

    var domainLookup: [Int: DomainDefinition] {
        Dictionary(uniqueKeysWithValues: domains.map { ($0.id, $0) })
    }

    func domain(for id: Int) -> DomainDefinition {
        domainLookup[id] ?? DomainDefinition(id: id, name: "未分類", shortName: "未分類")
    }

    func question(withID id: String) -> DrillQuestion? {
        questions.first { $0.id == id }
    }
}

struct DomainDefinition: Identifiable, Hashable {
    let id: Int
    let name: String
    let shortName: String
}

struct DrillQuestion: Identifiable, Hashable, Codable {
    let id: String
    let domain: Int
    let kind: String
    let prompt: String
    let options: [String]
    let answerIndex: Int
    let explanation: String
    let source: String
}

struct UpcomingExam: Identifiable {
    let id = UUID()
    let name: String
    let shortName: String
    let description: String
}

struct LearningModule: Identifiable, Hashable {
    let id: String
    let domainLabel: String
    let title: String
    let subtitle: String
    let colorHex: String
    let estimatedMinutes: Int
    let highlights: [String]
    let keyFacts: [LearningFact]
    let sections: [LearningSection]

    var tint: Color {
        Color(hex: colorHex)
    }

    var searchText: String {
        ([domainLabel, title, subtitle] + highlights + keyFacts.flatMap { [$0.label, $0.value, $0.note] } + sections.flatMap { section in
            [section.title, section.summary, section.source] + section.bullets
        })
        .joined(separator: " ")
    }
}

struct LearningExamGuide: Identifiable, Hashable {
    let id: String
    let title: String
    let shortName: String
    let subtitle: String
    let colorHex: String
    let modules: [LearningModule]

    var tint: Color {
        Color(hex: colorHex)
    }
}

struct LearningSection: Identifiable, Hashable {
    let id: String
    let title: String
    let summary: String
    let bullets: [String]
    let source: String
}

struct LearningFact: Identifiable, Hashable {
    let id: String
    let label: String
    let value: String
    let note: String
}

enum QuizMode: String, Codable {
    case practice
    case mock
    case wrong
    case bookmark
    case review

    var label: String {
        switch self {
        case .practice:
            return "練習"
        case .mock:
            return "模試"
        case .wrong:
            return "間違え直し"
        case .bookmark:
            return "ブックマーク"
        case .review:
            return "復習"
        }
    }

    var resultTitle: String {
        switch self {
        case .mock:
            return "模試結果"
        default:
            return "学習結果"
        }
    }
}

struct QuizItem: Identifiable, Hashable {
    let question: DrillQuestion
    let optionOrder: [Int]

    var id: String {
        question.id
    }

    var correctPosition: Int {
        optionOrder.firstIndex(of: question.answerIndex) ?? 0
    }

    func optionText(at position: Int) -> String {
        question.options[optionOrder[position]]
    }
}

struct QuizConfig: Identifiable {
    let id = UUID()
    let exam: ExamDefinition
    let mode: QuizMode
    let items: [QuizItem]
    let durationSeconds: Int?

    var title: String {
        "\(exam.shortName) \(mode.label)"
    }
}

struct AnswerOutcome: Identifiable, Hashable {
    let id = UUID()
    let questionID: String
    let domain: Int
    let isCorrect: Bool
}

struct DomainScoreResult: Identifiable, Hashable {
    let domainID: Int
    let domainName: String
    let correct: Int
    let total: Int

    var id: Int {
        domainID
    }

    var percent: Int {
        guard total > 0 else { return 0 }
        return Int((Double(correct) / Double(total) * 100).rounded())
    }
}

struct QuizResult: Identifiable {
    let id = UUID()
    let exam: ExamDefinition
    let mode: QuizMode
    let correct: Int
    let total: Int
    let domainScores: [DomainScoreResult]
    let outcomes: [AnswerOutcome]
    let completedAt: Date

    var percent: Int {
        guard total > 0 else { return 0 }
        return Int((Double(correct) / Double(total) * 100).rounded())
    }

    var passed: Bool {
        percent >= exam.passRate
    }

    var wrongQuestionIDs: [String] {
        outcomes.filter { !$0.isCorrect }.map(\.questionID)
    }
}

struct SessionRecord: Identifiable, Codable, Hashable {
    let id: UUID
    let examID: String
    let examShortName: String
    let modeRawValue: String
    let correct: Int
    let total: Int
    let percent: Int
    let completedAt: Date

    var mode: QuizMode {
        QuizMode(rawValue: modeRawValue) ?? .practice
    }
}
