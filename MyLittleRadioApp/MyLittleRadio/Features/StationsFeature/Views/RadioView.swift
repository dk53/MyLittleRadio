import SwiftUI

struct StationView: View {
    let title: String
    let showMusicIcon: Bool
    let color: UIColor?

    var body: some View {
        VStack {
            let color = color ?? .gray
            ZStack {
                Rectangle()
                    .fill(Color(color))
                    .frame(height: 100)
                    .cornerRadius(10)
                    .accessibilityHidden(true)

                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(color.isLight ? .black : .white)
                        .accessibilityLabel("Station name: \(title)")

                    if showMusicIcon {
                        Image(systemName: "music.note")
                            .foregroundColor(color.isLight ? .black : .white)
                    }
                }
                .accessibilityElement(children: .combine)
            }
        }
    }
}
