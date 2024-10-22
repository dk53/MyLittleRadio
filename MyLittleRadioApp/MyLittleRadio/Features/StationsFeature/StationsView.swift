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
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(store.stations) { station in
                        HStack(spacing: 8) {
                            Text(station.title)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .frame(height: 50)
                    }
                }
            }
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .task {
            store.send(.fetchStations)
        }
    }
}
