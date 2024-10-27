import SwiftUI
import Core

struct MiniPlayerView: View {

    enum Constants {
        static let playPauseIconSize: CGFloat = 40
        static let textPaddingLeading: CGFloat = 16
        static let buttonPaddingTrailing: CGFloat = 16
        static let viewHeight: CGFloat = 90
        static let cornerRadius: CGFloat = 20
        static let shadowRadius: CGFloat = 12
    }

    let station: Station
    let isPlaying: Bool
    let togglePlayPause: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            Text(station.title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, Constants.textPaddingLeading)

            Spacer()

            PlayPauseButton(
                isPlaying: isPlaying,
                foregroundColor: .white,
                iconSize: Constants.playPauseIconSize,
                togglePlayPause: togglePlayPause
            )
            .padding(.trailing, Constants.buttonPaddingTrailing)
        }
        .frame(height: Constants.viewHeight)
        .background(station.colors.primary.toColor)
        .cornerRadius(Constants.cornerRadius)
        .shadow(radius: Constants.shadowRadius)
    }
}

struct MiniPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MiniPlayerView(
                station: .mock1,
                isPlaying: true,
                togglePlayPause: { }
            )
            .previewDisplayName("France Inter Playing")
        }
        .previewLayout(.sizeThatFits)
    }
}
