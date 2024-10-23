// Copyright © Radio France. All rights reserved.

import SwiftUI
import ComposableArchitecture

struct StationsView: View {

    @Perception.Bindable private var store: StoreOf<StationsFeature>
    @State var selectedStation: Station?
    private let animationNamespace: Namespace.ID?

    init(store: StoreOf<StationsFeature>,
         selectedStation: Station? = nil,
         animationNamespace: Namespace.ID? = nil) {
        self.store = store
        self.selectedStation = selectedStation
        self.animationNamespace = animationNamespace
    }

    func test(viewStore: StoreOf<StationsFeature>, station: Station) {
        viewStore.send(.selectStation(station))
    }

    var body: some View {
        WithPerceptionTracking {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    stationList(viewStore: viewStore)
                    loadingIndicator
                }
                .alert($store.scope(state: \.alert, action: \.alert))
                .task {
                    viewStore.send(.fetchStations)
                }
                .navigationTitle("Stations")
                .navigationBarTitleDisplayMode(.automatic)
                .onChange(of: selectedStation) { newValue in
                    //TODO will remove later
                    if let station = newValue {
                        print("Selected Station: \(station.title)")
                    }
                }
            }
        }
    }

    // MARK: - Components

    @ViewBuilder
    private func stationList(viewStore: ViewStoreOf<StationsFeature>) -> some View {
        WithPerceptionTracking {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewStore.stations) { station in
                        StationView(
                            title: station.shortTitle,
                            showMusicIcon: station.isMusical,
                            color: station.colors.primary.toColor,
                            animation: AnimationIDs(
                                textId: station.title,
                                backgroundId: "\(station.title)_background",
                                namespace: animationNamespace
                            )
                        )
                        .zIndex(viewStore.selectedStation?.id == station.id ? 10 : 0)
                        .onTapGesture {
                            viewStore.send(.selectStation(station))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var loadingIndicator: some View {
        ProgressView()
            .opacity(store.isLoading ? 1 : 0)
            .scaleEffect(store.isLoading ? 1 : 0.5)
            .animation(.easeInOut(duration: 0.5), value: store.isLoading)
    }
}
