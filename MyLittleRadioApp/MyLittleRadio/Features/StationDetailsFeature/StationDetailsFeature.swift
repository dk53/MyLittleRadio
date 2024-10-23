import ComposableArchitecture

@Reducer
struct StationDetailsFeature {

    @ObservableState
    struct State: Equatable {
        var selectedStation: Station?
        var isPlaying: Bool = false
    }

    @CasePathable
    enum Action {
        case togglePlayPause
    }

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .togglePlayPause:
                state.isPlaying = !state.isPlaying
                return .none
            }
        }
    }
}
