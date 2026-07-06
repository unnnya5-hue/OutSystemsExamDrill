import Foundation
import Combine

@MainActor
final class DrillStore: ObservableObject {
    @Published private(set) var sessions: [SessionRecord] = [] {
        didSet { save() }
    }

    @Published private var wrongIDsByExam: [String: Set<String>] = [:] {
        didSet { save() }
    }

    @Published private var bookmarkIDsByExam: [String: Set<String>] = [:] {
        didSet { save() }
    }

    private let storageKey = "outSystemsExamDrill.store.v1"

    init() {
        load()
    }

    var totalAnswered: Int {
        sessions.reduce(0) { $0 + $1.total }
    }

    var totalCorrect: Int {
        sessions.reduce(0) { $0 + $1.correct }
    }

    var correctRate: Int? {
        guard totalAnswered > 0 else { return nil }
        return Int((Double(totalCorrect) / Double(totalAnswered) * 100).rounded())
    }

    func examRate(for examID: String) -> Int? {
        let filtered = sessions.filter { $0.examID == examID }
        let total = filtered.reduce(0) { $0 + $1.total }
        guard total > 0 else { return nil }
        let correct = filtered.reduce(0) { $0 + $1.correct }
        return Int((Double(correct) / Double(total) * 100).rounded())
    }

    func wrongCount(for examID: String) -> Int {
        wrongIDsByExam[examID, default: []].count
    }

    func bookmarkCount(for examID: String) -> Int {
        bookmarkIDsByExam[examID, default: []].count
    }

    func wrongIDs(for examID: String) -> Set<String> {
        wrongIDsByExam[examID, default: []]
    }

    func bookmarkIDs(for examID: String) -> Set<String> {
        bookmarkIDsByExam[examID, default: []]
    }

    func isBookmarked(questionID: String, examID: String) -> Bool {
        bookmarkIDsByExam[examID, default: []].contains(questionID)
    }

    func toggleBookmark(questionID: String, examID: String) {
        var ids = bookmarkIDsByExam[examID, default: []]
        if ids.contains(questionID) {
            ids.remove(questionID)
        } else {
            ids.insert(questionID)
        }
        bookmarkIDsByExam[examID] = ids
    }

    func markAnswered(questionID: String, examID: String, isCorrect: Bool) {
        var ids = wrongIDsByExam[examID, default: []]
        if isCorrect {
            ids.remove(questionID)
        } else {
            ids.insert(questionID)
        }
        wrongIDsByExam[examID] = ids
    }

    func record(result: QuizResult) {
        let record = SessionRecord(
            id: UUID(),
            examID: result.exam.id,
            examShortName: result.exam.shortName,
            modeRawValue: result.mode.rawValue,
            correct: result.correct,
            total: result.total,
            percent: result.percent,
            completedAt: result.completedAt
        )
        sessions.insert(record, at: 0)
        if sessions.count > 80 {
            sessions = Array(sessions.prefix(80))
        }
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let snapshot = try? JSONDecoder().decode(StoreSnapshot.self, from: data)
        else {
            return
        }

        sessions = snapshot.sessions
        wrongIDsByExam = snapshot.wrongIDsByExam.mapValues { Set($0) }
        bookmarkIDsByExam = snapshot.bookmarkIDsByExam.mapValues { Set($0) }
    }

    private func save() {
        let snapshot = StoreSnapshot(
            sessions: sessions,
            wrongIDsByExam: wrongIDsByExam.mapValues { Array($0).sorted() },
            bookmarkIDsByExam: bookmarkIDsByExam.mapValues { Array($0).sorted() }
        )
        guard let data = try? JSONEncoder().encode(snapshot) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}

private struct StoreSnapshot: Codable {
    var sessions: [SessionRecord]
    var wrongIDsByExam: [String: [String]]
    var bookmarkIDsByExam: [String: [String]]
}
