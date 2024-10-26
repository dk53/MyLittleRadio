import SwiftUI
import ComposableArchitecture

struct RadioView: View {
    private let title: String
    private let showMusicIcon: Bool
    private let color: Color
    private let isPlaying: Bool

    init(
        title: String,
        showMusicIcon: Bool = false,
        color: Color = .gray,
        isPlaying: Bool = false
    ) {
        self.title = title
        self.showMusicIcon = showMusicIcon
        self.color = color
        self.isPlaying = isPlaying
    }

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(color)
            .frame(minHeight: 100)
            .overlay(contentOverlay)
            .accessibilityElement(children: .combine)
            .accessibilityLabel(Text("Station name: \(title)"))
    }

    @ViewBuilder
    private var contentOverlay: some View {
        HStack {
            if isPlaying {
                AnimatedBarView()
            }
            Text(title)
                .font(.headline)
                .foregroundColor(color.isLight ? .black : .white)
                .padding(.leading, isPlaying ? 5 : 0)

            if showMusicIcon {
                Image(systemName: "music.note")
                    .foregroundColor(color.isLight ? .black : .white)
            }
        }
    }
}
