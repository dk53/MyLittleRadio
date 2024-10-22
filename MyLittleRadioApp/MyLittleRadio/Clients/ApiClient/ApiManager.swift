// Copyright © Radio France. All rights reserved.

import Foundation

final class ApiManager {

    func fetchStations() async throws -> [Station] {
        guard let url = URL(string: APIConfig.stationsEndpoint) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let stations = try JSONDecoder().decode([Station].self, from: data)
        return stations
    }
}
