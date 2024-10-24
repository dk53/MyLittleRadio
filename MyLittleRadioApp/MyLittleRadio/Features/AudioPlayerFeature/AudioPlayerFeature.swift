import ComposableArchitecture
import AVFoundation

@Reducer
struct AudioPlayerFeature {

    @ObservableState
    struct State: Equatable {
        var isPlaying: Bool = false
        var currentStationUrl: URL?
        var isLoading: Bool = false
    }

    enum Action: Equatable {
        case playPauseTapped
        case setStationUrl(URL)
        case playerStatusChanged(isPlaying: Bool)
    }

    @Dependency(\.audioPlayerClient)
    private var audioPlayerClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .playPauseTapped:
                if state.isPlaying {
                    return .run { send in
                        await audioPlayerClient.pause()
                        await send(.playerStatusChanged(isPlaying: false))
                    }
                } else if let url = state.currentStationUrl {
                    return .run { send in
                        await audioPlayerClient.playStream(url)
                        await send(.playerStatusChanged(isPlaying: true))
                    }
                }
                return .none

            case let .setStationUrl(url):
                state.currentStationUrl = url
                return .none

            case let .playerStatusChanged(isPlaying):
                state.isPlaying = isPlaying
                return .none
            }
        }
    }
}
