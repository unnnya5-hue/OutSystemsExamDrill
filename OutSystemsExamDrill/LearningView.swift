import SwiftUI

struct LearningView: View {
    @EnvironmentObject private var connectivity: NetworkStatusMonitor
    @EnvironmentObject private var adCoordinator: AdCoordinator
    @State private var selectedGuideID: String?
    @State private var selectedModule: LearningModule?

    private var selectedGuide: LearningExamGuide? {
        guard let selectedGuideID else { return nil }
        return LearningCatalog.guides.first { $0.id == selectedGuideID }
    }

    var body: some View {
        ZStack {
            Color.drillShell.ignoresSafeArea()

            if let selectedModule {
                LearningDetailView(module: selectedModule) {
                    self.selectedModule = nil
                    adCoordinator.showInterstitialAfterLearningDetailIfEligible(isOnline: connectivity.isOnline)
                }
            } else if let selectedGuide {
                LearningModuleListView(
                    guide: selectedGuide,
                    onBack: {
                        selectedGuideID = nil
                        selectedModule = nil
                    },
                    onSelect: { module in
                        selectedModule = module
                    }
                )
            } else {
                LearningGuideListView { guide in
                    selectedGuideID = guide.id
                }
            }
        }
    }
}

private struct LearningGuideListView: View {
    let onSelect: (LearningExamGuide) -> Void

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: "教材")

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    SectionLabel(text: "資格一覧")

                    ForEach(LearningCatalog.guides) { guide in
                        LearningGuideCard(guide: guide) {
                            onSelect(guide)
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

private struct LearningGuideCard: View {
    let guide: LearningExamGuide
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            DrillCard(accent: guide.tint) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 8) {
                            Badge(text: guide.shortName, color: guide.tint)

                            Text(guide.title)
                                .font(.headline.weight(.black))
                                .foregroundStyle(Color.drillInk)
                                .fixedSize(horizontal: false, vertical: true)

                            Text(guide.subtitle)
                                .font(.caption)
                                .foregroundStyle(Color.drillSubtext)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer(minLength: 8)

                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title3)
                            .foregroundStyle(guide.tint.opacity(0.9))
                    }

                    HStack(spacing: 12) {
                        Label("\(guide.modules.count)章", systemImage: "book.closed")
                        Label("\(guide.modules.flatMap(\.sections).count)要点", systemImage: "list.bullet")
                        Label("\(guide.modules.flatMap(\.keyFacts).count)頻出値", systemImage: "number")
                    }
                    .font(.caption2.monospaced())
                    .foregroundStyle(Color.drillSubtext)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

private struct LearningModuleListView: View {
    @State private var searchText = ""
    let guide: LearningExamGuide
    let onBack: () -> Void
    let onSelect: (LearningModule) -> Void

    private var filteredModules: [LearningModule] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return guide.modules }
        return guide.modules.filter {
            $0.searchText.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: "教材", backTitle: "資格一覧", onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    hero
                    searchField

                    ForEach(filteredModules) { module in
                        LearningModuleCard(module: module) {
                            onSelect(module)
                        }
                    }

                    if filteredModules.isEmpty {
                        emptySearch
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

    private var hero: some View {
        DrillCard(accent: guide.tint) {
            VStack(alignment: .leading, spacing: 10) {
                Badge(text: guide.shortName, color: guide.tint)

                Text(guide.title)
                    .font(.title3.weight(.black))
                    .foregroundStyle(Color.drillInk)
                    .fixedSize(horizontal: false, vertical: true)

                Text(guide.subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.drillSubtext)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(spacing: 10) {
                    LearningMiniMetric(value: "\(guide.modules.count)", label: "章")
                    LearningMiniMetric(
                        value: "\(guide.modules.flatMap(\.sections).count)",
                        label: "要点"
                    )
                    LearningMiniMetric(
                        value: "\(guide.modules.flatMap(\.keyFacts).count)",
                        label: "頻出値"
                    )
                }
            }
        }
    }

    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.drillSubtext)
            TextField("教材を検索", text: $searchText)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .font(.subheadline)
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.drillSubtext)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 13)
        .padding(.vertical, 11)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.drillLine, lineWidth: 1)
        }
    }

    private var emptySearch: some View {
        DrillCard {
            VStack(spacing: 8) {
                Image(systemName: "doc.text.magnifyingglass")
                    .font(.title2.weight(.bold))
                    .foregroundStyle(Color.drillSubtext)
                Text("一致する教材がありません")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(Color.drillInk)
                Text("別のキーワードで検索してください。")
                    .font(.caption)
                    .foregroundStyle(Color.drillSubtext)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
    }
}

private struct LearningModuleCard: View {
    let module: LearningModule
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            DrillCard(accent: module.tint) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top, spacing: 10) {
                        VStack(alignment: .leading, spacing: 8) {
                            Badge(text: module.domainLabel, color: module.tint)

                            Text(module.title)
                                .font(.headline.weight(.black))
                                .foregroundStyle(Color.drillInk)
                                .fixedSize(horizontal: false, vertical: true)

                            Text(module.subtitle)
                                .font(.caption)
                                .foregroundStyle(Color.drillSubtext)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer(minLength: 8)

                        Image(systemName: "chevron.right.circle.fill")
                            .font(.title3)
                            .foregroundStyle(module.tint.opacity(0.9))
                    }

                    HStack(spacing: 12) {
                        Label("\(module.estimatedMinutes)分", systemImage: "clock")
                        Label("\(module.sections.count)項目", systemImage: "list.bullet")
                        Label("\(module.keyFacts.count)頻出値", systemImage: "number")
                    }
                    .font(.caption2.monospaced())
                    .foregroundStyle(Color.drillSubtext)

                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(module.highlights.prefix(2), id: \.self) { highlight in
                            Label(highlight, systemImage: "checkmark.circle.fill")
                                .font(.caption2)
                                .foregroundStyle(Color.drillSubtext)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.top, 2)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

private struct LearningDetailView: View {
    let module: LearningModule
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            AppHeader(title: "教材", backTitle: "一覧", onBack: onBack)

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    detailHero

                    if !module.keyFacts.isEmpty {
                        SectionLabel(text: "数値・頻出値")
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(module.keyFacts) { fact in
                                LearningFactCard(fact: fact, tint: module.tint)
                            }
                        }
                    }

                    SectionLabel(text: "暗記ポイント")
                    DrillCard {
                        VStack(alignment: .leading, spacing: 9) {
                            ForEach(module.highlights, id: \.self) { highlight in
                                LearningBullet(text: highlight, tint: module.tint)
                            }
                        }
                    }

                    SectionLabel(text: "解説")
                    ForEach(module.sections) { section in
                        LearningSectionCard(section: section, tint: module.tint)
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

    private var detailHero: some View {
        DrillCard(accent: module.tint) {
            VStack(alignment: .leading, spacing: 10) {
                Badge(text: module.domainLabel, color: module.tint)
                Text(module.title)
                    .font(.title3.weight(.black))
                    .foregroundStyle(Color.drillInk)
                    .fixedSize(horizontal: false, vertical: true)
                Text(module.subtitle)
                    .font(.caption)
                    .foregroundStyle(Color.drillSubtext)
                    .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 12) {
                    Label("\(module.estimatedMinutes)分", systemImage: "clock")
                    Label("\(module.sections.count)項目", systemImage: "book.closed")
                    Label("\(module.keyFacts.count)頻出値", systemImage: "number")
                }
                .font(.caption2.monospaced())
                .foregroundStyle(Color.drillSubtext)
            }
        }
    }
}

private struct LearningSectionCard: View {
    let section: LearningSection
    let tint: Color

    var body: some View {
        DrillCard(accent: tint.opacity(0.75)) {
            VStack(alignment: .leading, spacing: 10) {
                Text(section.title)
                    .font(.subheadline.weight(.black))
                    .foregroundStyle(Color.drillInk)
                    .fixedSize(horizontal: false, vertical: true)

                Text(section.summary)
                    .font(.caption)
                    .foregroundStyle(Color.drillSubtext)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(section.bullets, id: \.self) { bullet in
                        LearningBullet(text: bullet, tint: tint)
                    }
                }

                Text(section.source)
                    .font(.caption2.monospaced())
                    .foregroundStyle(Color.drillSubtext)
                    .padding(.top, 2)
            }
        }
    }
}

private struct LearningFactCard: View {
    let fact: LearningFact
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(fact.label)
                .font(.caption2.weight(.bold))
                .foregroundStyle(Color.drillSubtext)
                .lineLimit(1)

            Text(fact.value)
                .font(.headline.monospaced().weight(.black))
                .foregroundStyle(tint)
                .minimumScaleFactor(0.72)
                .lineLimit(1)

            Text(fact.note)
                .font(.caption2)
                .foregroundStyle(Color.drillSubtext)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 84, alignment: .topLeading)
        .padding(12)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.drillLine, lineWidth: 1)
        }
    }
}

private struct LearningBullet: View {
    let text: String
    let tint: Color

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.caption.weight(.bold))
                .foregroundStyle(tint)
                .padding(.top, 1)
            Text(text)
                .font(.caption)
                .foregroundStyle(Color.drillInk)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct LearningMiniMetric: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.headline.monospaced().weight(.black))
                .foregroundStyle(Color.drillInk)
            Text(label)
                .font(.caption2.weight(.bold))
                .foregroundStyle(Color.drillSubtext)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color(hex: "#F3F6F9"), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

private struct SectionLabel: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.monospaced().weight(.semibold))
            .foregroundStyle(Color.drillSubtext)
            .padding(.top, 4)
    }
}
