import SwiftUI
import Core

struct DetailsView: View {
    let selectedStation: Station
    let foregroundColor: Color
    let onDismiss: () -> Void
    let isPlaying: Bool
    let togglePlayPause: () -> Void

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
                }
                .padding()
            )
            .ignoresSafeArea()
    }
}

struct StationHeaderView: View {
    let title: String
    let foregroundColor: Color
    let onDismiss: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(foregroundColor)

            Spacer()

            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .foregroundColor(foregroundColor)
                    .padding()
            }
        }
        .padding(.top, 16)
    }
}
