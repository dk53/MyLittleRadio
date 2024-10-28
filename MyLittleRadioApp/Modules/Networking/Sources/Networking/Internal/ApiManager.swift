import Foundation
import Core

final class ApiManager: Sendable {

    // MARK: - Fetch Stations

    func fetchStations() async throws -> [Station] {
        guard let url = URL(string: StationsEndpointConfiguration.stations) else {
            throw ApiError.invalidURL
        }

        #if DEBUG
        try await Task.sleep(nanoseconds: 2_000_000_000) // Simulated delay for debugging
        #endif

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(StationsResponse.self, from: data)
            return response.stations
        } catch let error as URLError {
            throw ApiError.networkError(error)
        } catch {
            throw ApiError.decodingError
        }
    }
}
