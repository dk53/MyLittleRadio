import ComposableArchitecture

@Reducer
struct AppFeature {

    @ObservableState
    struct State: Equatable {
        var stationsFeature: StationsFeature.State = StationsFeature.State()
        var stationDetailsFeature: StationDetailsFeature.State = StationDetailsFeature.State()

        var isDetailViewPresented: Bool = false
        var selectedStation: Station?
    }

    @CasePathable
    enum Action {
        case stationsFeature(StationsFeature.Action)
        case stationDetailsFeature(StationDetailsFeature.Action)
        case dismissStationDetails
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.stationsFeature, action: \.stationsFeature) {
            StationsFeature()
        }

        Scope(state: \.stationDetailsFeature, action: \.stationDetailsFeature) {
             StationDetailsFeature()
         }

        Reduce<State, Action> { state, action in
            switch action {
            case let .stationsFeature(.selectStation(station)):
                state.selectedStation = station
                state.isDetailViewPresented = true
                state.stationDetailsFeature = StationDetailsFeature.State(selectedStation: station)
                return .none
            case .stationsFeature:
                return .none
            case .stationDetailsFeature(_):
                return .none
            case .dismissStationDetails:
                state.selectedStation = nil
                state.isDetailViewPresented = false
                return .none
            }
        }
    }
}
