import UIKit
import SwiftUI

extension Color {

    var isLight: Bool {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let brightness = 0.299 * red + 0.587 * green + 0.114 * blue
        return brightness > 0.6
    }
}

extension String {

    var toColor: Color {
        // Adapted from here : https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values
        let hex = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let hexString = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex

        guard hexString.count == 6, let rgbValue = UInt64(hexString, radix: 16) else {
            return Color.gray
        }

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
}
