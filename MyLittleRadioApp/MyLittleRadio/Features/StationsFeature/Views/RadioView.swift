import SwiftUI
import ComposableArchitecture

struct StationView: View {
    private let title: String
    private let showMusicIcon: Bool
    private let color: UIColor?
    private let isPlaying: Bool
    
    init(title: String,
         showMusicIcon: Bool,
         color: UIColor? = nil,
         isPlaying: Bool) {
        self.title = title
        self.showMusicIcon = showMusicIcon
        self.color = color
        self.isPlaying = isPlaying
    }
    
    var body: some View {
        WithPerceptionTracking {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(color ?? .gray))
                .frame(minHeight: 100)
                .overlay(
                    HStack {
                        if isPlaying {
                            AnimatedBarView() // Show animated bar when playing
                        }
                        
                        Text(title)
                            .font(.headline)
                            .foregroundColor((color?.isLight ?? false) ? .black : .white)
                            .accessibilityLabel("Station name: \(title)")
                        
                        if showMusicIcon {
                            Image(systemName: "music.note")
                                .foregroundColor((color?.isLight ?? false) ? .black : .white)
                        }
                    }
                        .padding(.horizontal, 10)
                )
                .accessibilityHidden(true)
        }
    }
}
