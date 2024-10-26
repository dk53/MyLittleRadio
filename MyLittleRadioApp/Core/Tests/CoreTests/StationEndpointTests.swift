import XCTest
import Foundation
@testable import Core

final class StationTests: XCTestCase {

    func testStationDecoding() throws {
        let json = """
        {
          "stations": [
            {
              "id": "1",
              "brandId": "FRANCEINTER",
              "title": "France Inter",
              "hasTimeshift": true,
              "shortTitle": "Inter",
              "type": "on_air",
              "streamUrl": "https://icecast.radiofrance.fr/franceinter-midfi.mp3",
              "analytics": {
                "value": "france_inter",
                "stationAudienceId": 3
              },
              "liveRule": "apprf_inter_player",
              "colors": {
                "primary": "#e20134"
              },
              "isMusical": false
            }
          ]
        }
        """.data(using: .utf8)!

        let decodedResponse = try JSONDecoder().decode(StationsResponse.self, from: json)
        XCTAssertEqual(decodedResponse.stations.count, 1)

        let station = decodedResponse.stations[0]

        // Let's test a few variables in case we update the Station Model the json parsing should still work
        XCTAssertEqual(station.id, "1")
        XCTAssertEqual(station.title, "France Inter")
        XCTAssertEqual(station.type, Station.RadioType.onAir)
        XCTAssertFalse(station.isMusical)

    }
}
