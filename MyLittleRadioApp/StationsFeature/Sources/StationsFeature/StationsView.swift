import SwiftUI
import ComposableArchitecture
import Core

public struct StationsView: View {

    // MARK: - Constants

    private enum Constants {

        static let navigationTitle = "Stations"

        static let gridSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let gridColumns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        static let loadingScaleEffect: CGFloat = 0.5
        static let loadingAnimation = Animation.easeInOut(duration: 0.5)

        static let nowPlayingHeight: CGFloat = 60
        static let nowPlayingPadding: CGFloat = 16
    }

    // MARK: - Properties

    @Perception.Bindable private var store: StoreOf<StationsFeature>
    @State var selectedStation: Station?

    // MARK: - Init

    public init(store: StoreOf<StationsFeature>,
                selectedStation: Station? = nil) {
        self.store = store
        self.selectedStation = selectedStation
    }

    // MARK: - Body

    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                ZStack {
                    stationList
                    loadingIndicator
                }
                .alert($store.scope(state: \.alert, action: \.alert))
                .task {
                    store.send(.fetchStations)
                }
                .navigationTitle(Constants.navigationTitle)
                .navigationBarTitleDisplayMode(.automatic)

                Spacer()

                if let station = store.activeStation {
                    MiniPlayerView(
                        station: station,
                        isPlaying: store.isPlaying,
                        togglePlayPause: { store.send(.togglePlayPause) }
                    )
                    .onTapGesture {
                        store.send(.selectStation(station))
                    }
                }
            }
        }
    }

    // MARK: - Components

    @ViewBuilder
    private var stationList: some View {
        ScrollView {
            LazyVGrid(
                columns: Constants.gridColumns,
                spacing: Constants.gridSpacing
            ) {
                WithPerceptionTracking {
                    ForEach(store.stations) { station in
                        let isPlaying = store.activeStation == station && store.isPlaying
                        stationView(station, isPlaying: isPlaying)
                    }
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }

    @ViewBuilder
    private func stationView(_ station: Station, isPlaying: Bool) -> some View {
        RadioView(
            title: station.shortTitle,
            showMusicIcon: station.isMusical,
            color: station.colors.primary.toColor,
            isPlaying: isPlaying
        )
        .onTapGesture {
            store.send(.selectStation(station))
        }
    }

    private var loadingIndicator: some View {
        ProgressView()
            .opacity(store.isLoading ? 1 : 0)
            .scaleEffect(store.isLoading ? 1 : Constants.loadingScaleEffect)
            .animation(Constants.loadingAnimation, value: store.isLoading)
    }
}
