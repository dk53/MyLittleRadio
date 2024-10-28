import ComposableArchitecture
import Core
import Networking

@Reducer
public struct StationsFeature: Sendable {

    // MARK: - State

    @ObservableState
    public struct State: Equatable {

        public var stations: [Station] = []
        public var activeStation: Station?
        public var selectedStation: Station?
        public var isPlaying: Bool
        public var isLoading: Bool = false
        @Presents public var alert: AlertState<Alert>?

        public init(
            stations: [Station] = [],
            activeStation: Station? = nil,
            selectedStation: Station? = nil,
            isPlaying: Bool = false,
            isLoading: Bool = false,
            alert: AlertState<Alert>? = nil
        ) {
            self.stations = stations
            self.activeStation = activeStation
            self.selectedStation = selectedStation
            self.isPlaying = isPlaying
            self.isLoading = isLoading
            self.alert = alert
        }
    }

    // MARK: - Actions

    public enum Action {

        case fetchStations
        case stationsResponse(Result<[Station], Error>)
        case alert(PresentationAction<Alert>)
        case selectStation(Station)
        case deselect
        case togglePlayPause
    }

    // MARK: - Alert

    @CasePathable
    public enum Alert: Equatable {

        case retryButtonTapped
    }

    // MARK: - Dependencies

    @Dependency(\.apiClient)
    var apiClient

    public init() { }

    // MARK: - Reducer

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {

            // MARK: - Stations Fetching

            case .fetchStations:
                state.isLoading = true

                return .run { send in
                    do {
                        let stations = try await apiClient.fetchStations()
                        await send(.stationsResponse(.success(stations)))
                    } catch {
                        await send(.stationsResponse(.failure(error)))
                    }
                }

            case .stationsResponse(.success(let stations)):
                state.isLoading = false
                state.stations = stations

                return .none
            case .stationsResponse(.failure(let error)):
                state.isLoading = false
                state.alert = AlertState {
                    TextState("Error")
                } actions: {
                    ButtonState(action: .retryButtonTapped) {
                        TextState("Retry")
                    }
                } message: {
                    TextState("Failed to fetch stations: \(error.localizedDescription)")
                }

                return .none

            // MARK: - Alert

            case .alert(.presented(.retryButtonTapped)):
                return .send(.fetchStations)

            case .alert:
                return .none

            // MARK: - Station Selection

            case .selectStation(let station):
                state.selectedStation = station
                return .none
            case .deselect:
                if !state.isPlaying {
                    state.selectedStation = nil
                    state.activeStation = nil
                }
                return .none
            case .togglePlayPause:
                state.isPlaying.toggle()
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
