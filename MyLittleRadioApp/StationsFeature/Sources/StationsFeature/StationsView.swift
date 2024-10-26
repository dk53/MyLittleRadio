// Copyright © Radio France. All rights reserved.

import SwiftUI
import ComposableArchitecture
import Core

public struct StationsView: View {

    enum Constants {
        static let navigationTitle = "Stations"

        static let gridSpacing: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let gridColumns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        static let loadingScaleEffect: CGFloat = 0.5
        static let loadingAnimation = Animation.easeInOut(duration: 0.5)
    }

    @Perception.Bindable private var store: StoreOf<StationsFeature>
    @State var selectedStation: Station?

    public init(store: StoreOf<StationsFeature>,
                selectedStation: Station? = nil) {
        self.store = store
        self.selectedStation = selectedStation
    }

    public var body: some View {
        WithPerceptionTracking {
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
        }
    }

    // MARK: - Components

    @ViewBuilder
    var stationList: some View {
        ScrollView {
            LazyVGrid(
                columns: Constants.gridColumns,
                spacing: Constants.gridSpacing
            ) {
                WithPerceptionTracking {
                    ForEach(store.stations) { station in
                        let isPlaying = store.playingStation == station
                        stationView(station, isPlaying: isPlaying)
                    }
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
        }
    }

    @ViewBuilder
    func stationView(_ station: Station, isPlaying: Bool) -> some View {
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
