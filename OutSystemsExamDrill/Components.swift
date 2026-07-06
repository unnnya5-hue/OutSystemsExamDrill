import SwiftUI

extension Color {
    static let drillBackground = Color(hex: "#EEF1F4")
    static let drillShell = Color(hex: "#FAFBFC")
    static let drillCard = Color.white
    static let drillInk = Color(hex: "#182430")
    static let drillSubtext = Color(hex: "#5D6B7A")
    static let drillLine = Color(hex: "#E3E8EE")
    static let drillLineStrong = Color(hex: "#D2DAE3")
    static let drillBrand = Color(hex: "#0F3B57")
    static let drillODC = Color(hex: "#D9482B")
    static let drillO11 = Color(hex: "#1D6FA5")
    static let drillSuccess = Color(hex: "#2E8B57")
    static let drillDanger = Color(hex: "#C4432B")
    static let drillGold = Color(hex: "#C79A2E")

    init(hex: String) {
        let trimmed = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: trimmed).scanHexInt64(&value)

        let red: UInt64
        let green: UInt64
        let blue: UInt64
        switch trimmed.count {
        case 3:
            red = (value >> 8) * 17
            green = ((value >> 4) & 0xF) * 17
            blue = (value & 0xF) * 17
        default:
            red = value >> 16
            green = (value >> 8) & 0xFF
            blue = value & 0xFF
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: 1
        )
    }
}

struct DrillCard<Content: View>: View {
    let accent: Color?
    let content: Content

    init(accent: Color? = nil, @ViewBuilder content: () -> Content) {
        self.accent = accent
        self.content = content()
    }

    var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.drillCard)
                    .overlay(alignment: .leading) {
                        if let accent {
                            Rectangle()
                                .fill(accent)
                                .frame(width: 5)
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.drillLine, lineWidth: 1)
                    }
                    .shadow(color: Color.drillInk.opacity(0.08), radius: 18, x: 0, y: 8)
            }
    }
}

struct AppHeader: View {
    let title: String
    var backTitle: String?
    var onBack: (() -> Void)?
    var trailing: AnyView = AnyView(EmptyView())

    var body: some View {
        HStack(spacing: 10) {
            if let backTitle, let onBack {
                Button(action: onBack) {
                    Label(backTitle, systemImage: "chevron.left")
                        .labelStyle(.titleAndIcon)
                        .font(.subheadline.weight(.bold))
                }
                .foregroundStyle(Color.drillBrand)
            }

            Text(title)
                .font(.headline.weight(.black))
                .foregroundStyle(Color.drillInk)
                .lineLimit(1)

            Spacer(minLength: 8)
            trailing
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.drillLine)
                .frame(height: 1)
        }
    }
}

struct Badge: View {
    let text: String
    let color: Color
    var foreground: Color = .white

    var body: some View {
        Text(text)
            .font(.caption2.monospaced().weight(.bold))
            .foregroundStyle(foreground)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(color, in: Capsule())
    }
}

struct ProgressRing: View {
    let percent: Int?
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(hex: "#E5EAF0"), lineWidth: 5)
            Circle()
                .trim(from: 0, to: CGFloat(percent ?? 0) / 100)
                .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text(percent.map { "\($0)%" } ?? "-")
                .font(.caption2.monospaced().weight(.black))
                .foregroundStyle(Color.drillInk)
        }
        .frame(width: 52, height: 52)
    }
}

struct PrimaryActionButton: View {
    let title: String
    var tint: Color = .drillBrand
    var isGhost = false
    var isDisabled = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.black))
                .foregroundStyle(isGhost ? tint : .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background {
                    RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .fill(isGhost ? Color.clear : tint)
                        .overlay {
                            RoundedRectangle(cornerRadius: 13, style: .continuous)
                                .stroke(isGhost ? Color.drillLineStrong : Color.clear, lineWidth: 1.5)
                        }
                }
        }
        .buttonStyle(.plain)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.42 : 1)
    }
}

struct MetricCard: View {
    let value: String
    let label: String
    let symbol: String
    var tint: Color = .drillBrand

    var body: some View {
        DrillCard {
            VStack(alignment: .leading, spacing: 10) {
                Image(systemName: symbol)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(tint)
                Text(value)
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(Color.drillInk)
                Text(label)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color.drillSubtext)
            }
        }
    }
}

extension Date {
    var drillHistoryTime: String {
        formatted(.dateTime.month(.defaultDigits).day().hour().minute().locale(Locale(identifier: "ja_JP")))
    }
}
