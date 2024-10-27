import SwiftUI

public struct PlayPauseButton: View {
    
    enum Constants {
        static let defaultIconSize: CGFloat = 60
        static let topPadding: CGFloat = 20
        static let playIcon: String = "play.circle.fill"
        static let pauseIcon: String = "pause.circle.fill"
    }
    
    private let isPlaying: Bool
    private let foregroundColor: Color
    private let iconSize: CGFloat
    private let togglePlayPause: () -> Void
    
    public init(isPlaying: Bool, foregroundColor: Color, iconSize: CGFloat? = nil, togglePlayPause: @escaping () -> Void) {
        self.isPlaying = isPlaying
        self.foregroundColor = foregroundColor
        self.iconSize = iconSize ?? Constants.defaultIconSize
        self.togglePlayPause = togglePlayPause
    }
    
    public var body: some View {
        Button(action: togglePlayPause) {
            Image(systemName: isPlaying ? Constants.pauseIcon : Constants.playIcon)
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(foregroundColor)
        }
    }
}
