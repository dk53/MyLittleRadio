import SwiftUI
import ComposableArchitecture
import StationDetailsFeature

struct AppView: View {

    @Perception.Bindable var store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                StationsView( store: store.scope(state: \.stationsFeature, action: \.stationsFeature))
                    .allowsHitTesting(!store.isDetailViewPresented)
                    .blur(radius: store.isDetailViewPresented ? 10 : 0)

                    .sheet(isPresented: Binding(
                        get: { store.state.isDetailViewPresented },
                        set: { _ in store.send(.dismissStationDetails) }
                    )) {
                        StationDetailsView(
                            store: store.scope(state: \.stationDetailsFeature, action: \.stationDetailsFeature),
                            onDismiss: {
                                store.send(.dismissStationDetails)
                            }
                        )
                        .presentationDetents([.height(250)])
                        .presentationDragIndicator(.hidden)
                    }
            }
        }
    }
}
