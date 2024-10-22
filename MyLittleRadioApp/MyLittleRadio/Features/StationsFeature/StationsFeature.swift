// Copyright © Radio France. All rights reserved.

import ComposableArchitecture

@Reducer
struct StationsFeature {

    @ObservableState
    struct State: Equatable {
        var stations: [Station] = []
        var isLoading: Bool = false
        @Presents var alert: AlertState<Action.Alert>?
    }

    enum Action {
        case fetchStations
        case stationsResponse(Result<[Station], Error>)
        case alert(PresentationAction<Alert>)

        @CasePathable
        enum Alert: Equatable {
              case retryButtonTapped
          }
    }

    // MARK: - Dependencies

    @Dependency(\.apiClient)
    private var apiClient

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
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
                
            case let .stationsResponse(.success(stations)):
                state.isLoading = false
                state.stations = stations
                
                return .none

            case let .stationsResponse(.failure(error)):
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

            case .alert(.presented(.retryButtonTapped)):
                return .send(.fetchStations)

            case .alert:
                 return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
