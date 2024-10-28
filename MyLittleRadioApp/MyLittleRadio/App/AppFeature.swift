import Foundation
import ComposableArchitecture
import Core
import AudioPlayerFeature
import StationsFeature
import StationDetailsFeature

@Reducer
struct AppFeature {

    // MARK: - State

    @ObservableState
    struct State: Equatable {

        var stationsFeature: StationsFeature.State = StationsFeature.State()
        var stationDetailsFeature: StationDetailsFeature.State = StationDetailsFeature.State()
        var audioPlayerFeature: AudioPlayerFeature.State = AudioPlayerFeature.State()

        var isDetailViewPresented: Bool = false
        var selectedStation: Station?
    }

    // MARK: - Actions

    @CasePathable
    enum Action {

        case stationsFeature(StationsFeature.Action)
        case stationDetailsFeature(StationDetailsFeature.Action)
        case audioPlayerFeature(AudioPlayerFeature.Action)
        case dismissStationDetails
    }

    // MARK: - Reducer

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

            // MARK: - Stations Feature Actions

            case .stationsFeature(.selectStation(let station)):
                state.selectedStation = station
                state.isDetailViewPresented = true

                let isPlaying = state.audioPlayerFeature.activeStation == station && state.audioPlayerFeature.isPlaying
                state.stationDetailsFeature = StationDetailsFeature.State(
                    selectedStation: station,
                    isPlaying: isPlaying
                )

                return .send(.audioPlayerFeature(.setActiveStation(station: station)))

            case .stationsFeature(.togglePlayPause):
                return .send(.audioPlayerFeature(.playPauseTapped))
            case .stationsFeature:
                return .none

            // MARK: - Station Details Feature Actions

            case .stationDetailsFeature(.togglePlayPause):
                return .send(.audioPlayerFeature(.playPauseTapped))

            case .stationDetailsFeature:
                return .none

            // MARK: - Dismiss Actions

            case .dismissStationDetails:
                state.selectedStation = nil
                state.isDetailViewPresented = false

                return .send(.stationsFeature(.deselect))

            // MARK: - Audio Player Feature Actions

            case .audioPlayerFeature(.playerStatusChanged(let isPlaying)):
                if let station = state.selectedStation {
                    state.stationsFeature.activeStation = station
                }
                state.stationsFeature.isPlaying = isPlaying

                return .none
            case .audioPlayerFeature:
                return .none
            }
        }
    }
}
