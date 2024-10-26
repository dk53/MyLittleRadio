import SwiftUI
import ComposableArchitecture
import Core

public struct StationDetailsView: View {
    @Perception.Bindable var store: StoreOf<StationDetailsFeature>

    private var onDismiss: () -> Void

    public init(
        store: StoreOf<StationDetailsFeature>,
        onDismiss: @escaping () -> Void
    ) {
        self.store = store
        self.onDismiss = onDismiss
    }

    public var body: some View {
        WithPerceptionTracking {
            if let selectedStation = store.selectedStation {
                DetailsView(
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
