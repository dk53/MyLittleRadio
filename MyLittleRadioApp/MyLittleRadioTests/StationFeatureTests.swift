import XCTest
import ComposableArchitecture

@testable import MyLittleRadio

final class StationsFeatureTests: XCTestCase {

    func testFetchStationsSuccess() async throws {
        let store = await TestStore(
            initialState: StationsFeature.State(),
            reducer: { StationsFeature() }
        )

        let mockStations = [Station.defaultStation]
        await MainActor.run {
            store.dependencies.apiClient.fetchStations = { mockStations }
        }

        await store.send(.fetchStations) {
            $0.isLoading = true
        }

        await store.receive(\.stationsResponse) {
            $0.stations = mockStations
            $0.isLoading = false
        }
    }

    func testFetchStationsFailure() async throws {
        let store = await TestStore(
            initialState: StationsFeature.State(),
            reducer: { StationsFeature() }
        )

        let mockError = NSError(domain: "Test", code: 42, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        await MainActor.run {
            store.dependencies.apiClient.fetchStations = { throw mockError }
        }

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
}
