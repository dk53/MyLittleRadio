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
        case stopPlayback
        case setStationUrl(URL)
        case playerStatusChanged(isPlaying: Bool)
        case loadingStarted
        case loadingFinished
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

            case .stopPlayback:
                return .run { send in
                    await audioPlayerClient.stop()
                    await send(.playerStatusChanged(isPlaying: false))
                }

            case let .setStationUrl(url):
                state.currentStationUrl = url
                return .none

            case let .playerStatusChanged(isPlaying):
                state.isPlaying = isPlaying
                return .none

            case .loadingStarted:
                state.isLoading = true
                return .none

            case .loadingFinished:
                state.isLoading = false
                state.isPlaying = true
                return .none
            }
        }
    }
}
