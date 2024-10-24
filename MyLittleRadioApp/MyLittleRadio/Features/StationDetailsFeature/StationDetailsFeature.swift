import ComposableArchitecture

@Reducer
struct StationDetailsFeature {

    @ObservableState
    struct State: Equatable {
        var selectedStation: Station?
        var isPlaying: Bool = false
        var audioPlayer: AudioPlayerFeature.State?
    }

    @CasePathable
    enum Action {
        case togglePlayPause
        case audioPlayer(AudioPlayerFeature.Action)
    }

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .togglePlayPause:
                state.isPlaying = !state.isPlaying
                return .send(.audioPlayer(.playPauseTapped))
            case .audioPlayer(_):
                return .none
            }
        }
    }
}
