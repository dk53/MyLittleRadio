import ComposableArchitecture
import AVFoundation
import Core

@Reducer
public struct AudioPlayerFeature: Sendable {

    @ObservableState
    public struct State: Equatable {
        public var isPlaying: Bool = false
        public var activeStation: Station?
        public var isLoading: Bool = false

        public init(isPlaying: Bool = false, activeStation: Station? = nil, isLoading: Bool = false) {
            self.isPlaying = isPlaying
            self.activeStation = activeStation
            self.isLoading = isLoading
        }
    }

    public enum Action: Equatable {
        case playPauseTapped
        case setActiveStation(station: Station)
        case playerStatusChanged(isPlaying: Bool)
    }

    public init() { }

    @Dependency(\.audioPlayerClient)
    private var audioPlayerClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .playPauseTapped:
                if state.isPlaying {
                    return .run { send in
                        await audioPlayerClient.pause()
                        await send(.playerStatusChanged(isPlaying: false))
                    }
                } else if let url = state.activeStation?.url {
                    return .run { send in
                        await audioPlayerClient.playStream(url)
                        await send(.playerStatusChanged(isPlaying: true))
                    }
                }
                return .none
            case .playerStatusChanged(let isPlaying):
                state.isPlaying = isPlaying
                return .none
            case .setActiveStation(let station):
                state.isPlaying = station == state.activeStation
                state.activeStation = station
                return .none
            }
        }
    }
}
