import SwiftUI
import Core

struct MiniPlayerView: View {

    // MARK: - Constants

    private enum Constants {

        static let playPauseIconSize: CGFloat = 40
        static let textPaddingLeading: CGFloat = 16
        static let buttonPaddingTrailing: CGFloat = 16
        static let viewHeight: CGFloat = 90
        static let shadowRadius: CGFloat = 8
    }

    // MARK: - Properties

    private let station: Station
    private let isPlaying: Bool
    private let togglePlayPause: () -> Void

    init(station: Station, isPlaying: Bool, togglePlayPause: @escaping () -> Void) {
        self.station = station
        self.isPlaying = isPlaying
        self.togglePlayPause = togglePlayPause
    }

    // MARK: - Body

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
