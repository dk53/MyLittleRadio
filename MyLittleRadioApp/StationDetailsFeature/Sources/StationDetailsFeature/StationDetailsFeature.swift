import ComposableArchitecture
import Core
import AudioPlayerFeature

@Reducer
struct StationDetailsFeature: Reducer {

    @ObservableState
    public struct State: Equatable {
        var selectedStation: Station?
        var isPlaying: Bool = false
        var audioPlayer: AudioPlayerFeature.State?

        public init(
            selectedStation: Station? = nil,
            isPlaying: Bool = false,
            audioPlayer: AudioPlayerFeature.State? = nil
        ) {
            self.selectedStation = selectedStation
            self.isPlaying = isPlaying
            self.audioPlayer = audioPlayer
        }
    }

    @CasePathable
    enum Action {
        case togglePlayPause
        case audioPlayer(AudioPlayerFeature.Action)
    }

    public init() { }

   // todo, check if it's better to add a state variable var audioPlayer: AudioPlayerFeature.State? or
//    use
  //  @Dependency(\.audioPlayerClient) private var audioPlayerClient

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .togglePlayPause:
                state.isPlaying.toggle()
                return .send(.audioPlayer(.playPauseTapped))
            case .audioPlayer:
                return .none
            }
        }
    }
}
