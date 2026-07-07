import SwiftUI

enum Theme {
    static let accent = Color(hex: "#6B5B3E")
    static let accent2 = Color(hex: "#D6C08F")
    static let background = Color(hex: "#141109")
    static let card = Color(hex: "#141109").opacity(0.6)
    static let titleFont: Font = .system(.title2, design: .serif).weight(.bold)
    static let bodyFont: Font = .system(.body, design: .rounded)
    static let cardCorner: CGFloat = 16
}

extension Color {
    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: h).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
