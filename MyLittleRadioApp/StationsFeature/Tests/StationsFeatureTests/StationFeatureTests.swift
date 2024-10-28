import XCTest
import Core
import ComposableArchitecture

@testable import StationsFeature

final class StationsFeatureTests: XCTestCase {

    @MainActor
    func testFetchStationsSuccess() async throws {
        let mockStations = [Station.mock1]
        let store = TestStore(
            initialState: StationsFeature.State(),
            reducer: {
                StationsFeature()
            },
            withDependencies: {
                $0.apiClient.fetchStations = { mockStations }
            })

        await store.send(.fetchStations) {
            $0.isLoading = true
        }

        await store.receive(\.stationsResponse) {
            $0.stations = mockStations
            $0.isLoading = false
        }
    }

    func testFetchStationsFailure() async throws {
        let mockError = NSError(domain: "Test", code: 42, userInfo: [NSLocalizedDescriptionKey: "Test Error"])

        let store = await TestStore(
            initialState: StationsFeature.State(),
            reducer: {
                StationsFeature()
            },
            withDependencies: {
                $0.apiClient.fetchStations = {
                    throw mockError
                }
            }
        )

        await store.send(.fetchStations) {
            $0.isLoading = true
        }

        await store.receive(\.stationsResponse) {
            $0.isLoading = false
            $0.alert = AlertState {
                TextState("Error")
            } actions: {
                ButtonState(action: .retryButtonTapped) {
                    TextState("Retry")
                }
            } message: {
                TextState("Failed to fetch stations: Test Error")
            }
        }
    }

    func testSelectStation() async {
        let store = await TestStore(
            initialState: StationsFeature.State(
                stations: [
                    Station.mock1,
                    Station.mock2
                ]
            ),
            reducer: {
                StationsFeature()
            }
        )

        await store.send(.selectStation(Station.mock1)) {
            $0.selectedStation = Station.mock1
        }
    }

    func testDeselectStation() async {
        let store = await TestStore(
            initialState: StationsFeature.State(stations: [Station.mock1, Station.mock2], selectedStation: Station.mock1),
            reducer: { StationsFeature() }
        )

        await store.send(.deselect) {
            $0.selectedStation = nil
        }
    }
}
