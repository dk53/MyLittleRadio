import SwiftUI

struct PlayPauseButton: View {

    enum Constants {
        static let iconSize: CGFloat = 60
        static let topPadding: CGFloat = 20
        static let playIcon: String = "play.circle.fill"
        static let pauseIcon: String = "pause.circle.fill"
    }

    let isPlaying: Bool
    let foregroundColor: Color
    let togglePlayPause: () -> Void

    var body: some View {
        Button(action: togglePlayPause) {
            Image(systemName: isPlaying ? Constants.pauseIcon : Constants.playIcon)
                .resizable()
                .frame(width: Constants.iconSize, height: Constants.iconSize)
                .foregroundColor(foregroundColor)
                .padding(.top, Constants.topPadding)
        }
    }
}
