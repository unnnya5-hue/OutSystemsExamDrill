import SwiftUI

struct ModeView: View {
    @EnvironmentObject private var store: DrillStore
    let exam: ExamDefinition
    let onBack: () -> Void
    let onStart: (QuizMode, Set<Int>) -> Void
    @State private var selectedDomains: Set<Int>

    init(
        exam: ExamDefinition,
        onBack: @escaping () -> Void,
        onStart: @escaping (QuizMode, Set<Int>) -> Void
    ) {
        self.exam = exam
        self.onBack = onBack
        self.onStart = onStart
        _selectedDomains = State(initialValue: Set(exam.domains.map(\.id)))
    }

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: exam.shortName, backTitle: "戻る", onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 13) {
                    header

                    ModeActionRow(
                        symbol: "pencil.and.list.clipboard",
                        title: "練習モード",
                        subtitle: "1問ごとに正誤と解説を確認",
                        tint: exam.tint,
                        action: {
                            onStart(.practice, selectedDomains)
                        }
                    )

                    Text("出題範囲")
                        .font(.caption.monospaced().weight(.semibold))
                        .foregroundStyle(Color.drillSubtext)
                        .padding(.top, 2)

                    domainFilters

                    ModeActionRow(
                        symbol: "timer",
                        title: "模試モード",
                        subtitle: "本番形式 \(exam.mockQuestionCount)問・\(exam.mockMinutes)分タイマー",
                        tint: Color.drillBrand,
                        action: {
                            onStart(.mock, selectedDomains)
                        }
                    )

                    ModeActionRow(
                        symbol: "xmark.circle.fill",
                        title: "間違えた問題",
                        subtitle: "正解すると誤答リストから消えます",
                        tint: Color.drillDanger,
                        count: store.wrongCount(for: exam.id),
                        isDisabled: store.wrongCount(for: exam.id) == 0,
                        action: {
                            onStart(.wrong, selectedDomains)
                        }
                    )

                    ModeActionRow(
                        symbol: "star.fill",
                        title: "ブックマーク",
                        subtitle: "保存した問題だけをまとめて復習",
                        tint: Color.drillGold,
                        count: store.bookmarkCount(for: exam.id),
                        isDisabled: store.bookmarkCount(for: exam.id) == 0,
                        action: {
                            onStart(.bookmark, selectedDomains)
                        }
                    )
                }
                .padding(.horizontal, 18)
                .padding(.top, 22)
                .padding(.bottom, 32)
                .frame(maxWidth: 430)
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.drillShell)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(exam.name)
                .font(.system(size: 22, weight: .black, design: .rounded))
                .foregroundStyle(Color.drillInk)
                .fixedSize(horizontal: false, vertical: true)
            Text(exam.description)
                .font(.caption)
                .foregroundStyle(Color.drillSubtext)
        }
    }

    private var domainFilters: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
            ForEach(exam.domains) { domain in
                Button {
                    toggle(domain: domain.id)
                } label: {
                    Text(domain.shortName)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(selectedDomains.contains(domain.id) ? .white : Color.drillSubtext)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background {
                            Capsule()
                                .fill(selectedDomains.contains(domain.id) ? exam.tint : Color.white)
                                .overlay {
                                    Capsule()
                                        .stroke(Color.drillLineStrong, lineWidth: selectedDomains.contains(domain.id) ? 0 : 1.5)
                                }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.bottom, 2)
    }

    private func toggle(domain: Int) {
        if selectedDomains.contains(domain) {
            guard selectedDomains.count > 1 else { return }
            selectedDomains.remove(domain)
        } else {
            selectedDomains.insert(domain)
        }
    }
}

private struct ModeActionRow: View {
    let symbol: String
    let title: String
    let subtitle: String
    let tint: Color
    var count: Int?
    var isDisabled = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            DrillCard {
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(tint)
                        Image(systemName: symbol)
                            .font(.title3.weight(.black))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 44, height: 44)

                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 7) {
                            Text(title)
                                .font(.subheadline.weight(.black))
                                .foregroundStyle(Color.drillInk)
                            if let count {
                                Text("\(count)")
                                    .font(.caption2.monospaced().weight(.black))
                                    .foregroundStyle(Color.drillSubtext)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(Color(hex: "#EDF0F4"), in: Capsule())
                            }
                        }
                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(Color.drillSubtext)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer(minLength: 0)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.45 : 1)
    }
}
