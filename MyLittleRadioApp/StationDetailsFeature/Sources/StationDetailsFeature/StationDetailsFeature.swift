import ComposableArchitecture
import Core

@Reducer
public struct StationDetailsFeature: Reducer {

    // MARK: - State

    @ObservableState
    public struct State: Equatable {

        public var selectedStation: Station?
        public var isPlaying: Bool

        // MARK: - Init

        public init(
            selectedStation: Station? = nil,
            isPlaying: Bool = false
        ) {
            self.selectedStation = selectedStation
            self.isPlaying = isPlaying
        }
    }

    // MARK: - Actions

    @CasePathable
    public enum Action {
        case togglePlayPause
    }

    // MARK: - Init

    public init() { }

    // MARK: - Reducer

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
