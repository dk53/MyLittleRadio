// Copyright © Radio France. All rights reserved.

import SwiftUI
import ComposableArchitecture

struct StationsView: View {

    @Perception.Bindable private var store: StoreOf<StationsFeature>
    @State var selectedStation: Station?

    init(store: StoreOf<StationsFeature>,
         selectedStation: Station? = nil) {
        self.store = store
        self.selectedStation = selectedStation
    }

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                stationList
                loadingIndicator
            }
            .alert($store.scope(state: \.alert, action: \.alert))
            .task {
                store.send(.fetchStations)
            }
            .navigationTitle("Stations")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }

    // MARK: - Components

    @ViewBuilder
    var stationList: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {
                WithPerceptionTracking {
                    ForEach(store.stations) { station in
                        let isPlaying = store.playingStation == station
                        stationView(station, isPlaying: isPlaying)
                    }
                }
            }
            .padding(.horizontal)
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
        .zIndex(store.selectedStation?.id == station.id ? 10 : 0)
        .onTapGesture {
            store.send(.selectStation(station))
        }
    }

    private var loadingIndicator: some View {
        ProgressView()
            .opacity(store.isLoading ? 1 : 0)
            .scaleEffect(store.isLoading ? 1 : 0.5)
            .animation(.easeInOut(duration: 0.5), value: store.isLoading)
    }
}
