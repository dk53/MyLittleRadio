import SwiftUI
import Core

struct DetailsView: View {

    // MARK: - Properties

    private let selectedStation: Station
    private let foregroundColor: Color
    private let isPlaying: Bool
    private let togglePlayPause: () -> Void
    private let onDismiss: () -> Void

    // MARK: - Init

    init(
        selectedStation: Station,
        foregroundColor: Color,
        isPlaying: Bool,
        togglePlayPause: @escaping () -> Void,
        onDismiss: @escaping () -> Void
    ) {
        self.selectedStation = selectedStation
        self.foregroundColor = foregroundColor
        self.isPlaying = isPlaying
        self.togglePlayPause = togglePlayPause
        self.onDismiss = onDismiss
    }

    // MARK: - Body

    var body: some View {
        Rectangle()
            .fill(selectedStation.colors.primary.toColor)
            .overlay(
                VStack {
                    StationHeaderView(
                        title: selectedStation.title,
                        foregroundColor: foregroundColor,
                        onDismiss: onDismiss
                    )
                    PlayPauseButton(
                        isPlaying: isPlaying,
                        foregroundColor: foregroundColor,
                        togglePlayPause: togglePlayPause
                    )
                    Spacer()
                }.padding()
            ).ignoresSafeArea()
    }
}
