// Copyright © Radio France. All rights reserved.

import Foundation

final class ApiManager {

    func fetchStations() async throws -> [Station] {
        guard let url = URL(string: APIConfig.stationsEndpoint) else {
            throw URLError(.badURL)
        }

#if DEBUG
        try await Task.sleep(nanoseconds: 2_000_000_000) // To simulate delay to see the loading, only for debug
#endif
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(StationsResponse.self, from: data)
        return response.stations
    }
}
