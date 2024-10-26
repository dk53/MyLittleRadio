import SwiftUI
import ComposableArchitecture
import Core

struct StationDetailsView: View {
    @Perception.Bindable var store: StoreOf<StationDetailsFeature>

    private var onDismiss: () -> Void

    init(
        store: StoreOf<StationDetailsFeature>,
        onDismiss: @escaping () -> Void
    ) {
        self.store = store
        self.onDismiss = onDismiss
    }

    var body: some View {
        WithPerceptionTracking {
            if let selectedStation = store.selectedStation {
                StationBackgroundView(
                    selectedStation: selectedStation,
                    foregroundColor: selectedStation.colors.primary.toColor.isLight ? .black : .white,
                    onDismiss: onDismiss,
                    isPlaying: store.isPlaying,
                    togglePlayPause: { store.send(.togglePlayPause) }
                )
            }
        }
    }
}

struct StationBackgroundView: View {
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

struct PlayPauseButton: View {
    let isPlaying: Bool
    let foregroundColor: Color
    let togglePlayPause: () -> Void

    var body: some View {
        Button(action: togglePlayPause) {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(foregroundColor)
                .padding(.top, 20)
        }
    }
}
