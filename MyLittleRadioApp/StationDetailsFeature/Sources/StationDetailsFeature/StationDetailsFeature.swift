import ComposableArchitecture
import Core

@Reducer
public struct StationDetailsFeature: Reducer {

    @ObservableState
    public struct State: Equatable {
        public var selectedStation: Station?
        public var isPlaying: Bool = false

        public init(
            selectedStation: Station? = nil,
            isPlaying: Bool = false
        ) {
            self.selectedStation = selectedStation
            self.isPlaying = isPlaying
        }
    }

    @CasePathable
    public enum Action {
        case togglePlayPause
    }

    public init() { }

   // todo, check if it's better to add a state variable var audioPlayer: AudioPlayerFeature.State? or
//    use
  //  @Dependency(\.audioPlayerClient) private var audioPlayerClient

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .togglePlayPause:
                state.isPlaying.toggle()
                return .none
            }
        }
    }
}
