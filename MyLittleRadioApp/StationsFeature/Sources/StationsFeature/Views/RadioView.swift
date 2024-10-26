import SwiftUI
import ComposableArchitecture

struct RadioView: View {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let minHeight: CGFloat = 100
        static let leadingPaddingWithBar: CGFloat = 5
    }
    
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
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(color)
            .frame(minHeight: Constants.minHeight)
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
                .padding(.leading, isPlaying ? Constants.leadingPaddingWithBar : 0)
            
            if showMusicIcon {
                Image(systemName: "music.note")
                    .foregroundColor(color.isLight ? .black : .white)
            }
        }
    }
}
