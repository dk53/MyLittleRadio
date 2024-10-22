// Copyright © Radio France. All rights reserved.

import SwiftUI
import ComposableArchitecture

struct StationsView: View {

    @Perception.Bindable private var store: StoreOf<StationsFeature>
    @State var selectedStation: Station?

    init(store: StoreOf<StationsFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(store.stations) { station in
                            StationView(title: station.title, showMusicIcon: station.isMusical, color: station.colors.primary.toColor)
                        }
                    }
                    .padding(.horizontal)
                }

                ProgressView()
                    .opacity(store.isLoading ? 1 : 0)
                    .scaleEffect(store.isLoading ? 1 : 0.5)
                    .animation(.easeInOut(duration: 0.5), value: store.isLoading)
            }
            .alert($store.scope(state: \.alert, action: \.alert))
            .task {
                store.send(.fetchStations)
            }
            .navigationTitle("Stations")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
