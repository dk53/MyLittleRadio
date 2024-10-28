import SwiftUI
import ComposableArchitecture
import Core

public struct StationDetailsView: View {

    // MARK: - Properties

    @Perception.Bindable private var store: StoreOf<StationDetailsFeature>
    private let onDismiss: () -> Void

    // MARK: - Init

    public init(
        store: StoreOf<StationDetailsFeature>,
        onDismiss: @escaping () -> Void
    ) {
        self.store = store
        self.onDismiss = onDismiss
    }

    // MARK: - Body

    public var body: some View {
        WithPerceptionTracking {
            if let selectedStation = store.selectedStation {
                DetailsView(
                    selectedStation: selectedStation,
                    foregroundColor: selectedStation.colors.primary.toColor.isLight ? .black : .white,
                    isPlaying: store.isPlaying,
                    togglePlayPause: { store.send(.togglePlayPause) },
                    onDismiss: onDismiss
                )
            }
        }
    }
}
