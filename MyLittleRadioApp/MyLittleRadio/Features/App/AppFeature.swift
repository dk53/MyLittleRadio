import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {

    @ObservableState
    struct State: Equatable {
        var stationsFeature: StationsFeature.State = StationsFeature.State()
        var stationDetailsFeature: StationDetailsFeature.State = StationDetailsFeature.State()
        var audioPlayerFeature: AudioPlayerFeature.State = AudioPlayerFeature.State()

        var isDetailViewPresented: Bool = false
        var selectedStation: Station?
    }

    @CasePathable
    enum Action {
        case stationsFeature(StationsFeature.Action)
        case stationDetailsFeature(StationDetailsFeature.Action)
        case audioPlayerFeature(AudioPlayerFeature.Action)

        case dismissStationDetails
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.stationsFeature, action: \.stationsFeature) {
            StationsFeature()
        }

        Scope(state: \.stationDetailsFeature, action: \.stationDetailsFeature) {
             StationDetailsFeature()
         }

        Scope(state: \.audioPlayerFeature, action: \.audioPlayerFeature) {
            AudioPlayerFeature()
        }

        Reduce<State, Action> { state, action in
            switch action {
            case let .stationsFeature(.selectStation(station)):
                state.selectedStation = station
                state.isDetailViewPresented = true
                state.stationDetailsFeature = StationDetailsFeature.State(
                    selectedStation: station,
                    isPlaying: state.audioPlayerFeature.isPlaying
                )
                return .send(.audioPlayerFeature(.setStationUrl(URL(string: station.streamUrl)!)))
            case .stationsFeature:
                return .none
            case .stationDetailsFeature(.togglePlayPause):
                return .send(.audioPlayerFeature(.playPauseTapped))
            case .dismissStationDetails:
                state.selectedStation = nil
                state.isDetailViewPresented = false
                return .none
            case .audioPlayerFeature(_):
                return .none
            case .stationDetailsFeature(.audioPlayer(_)):
                return .none
            }
        }
    }
}
