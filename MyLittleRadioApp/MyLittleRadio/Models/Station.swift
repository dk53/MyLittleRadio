// Copyright © Radio France. All rights reserved.

import Foundation

struct StationsResponse: Codable {
    let stations: [Station]
}

struct Station: Codable, Equatable, Identifiable, Hashable {

    struct Analytics: Codable, Equatable, Hashable {
        let value: String
        let stationAudienceId: Int
    }

    struct Colors: Codable, Equatable, Hashable {
        let primary: String
    }

    struct Assets: Codable, Equatable, Hashable {
        let squareImageUrl: String?
    }

    enum RadioType: String, Equatable, Codable, Hashable {
        case onAir = "on_air"
        case locale
    }

    let id: String
    let title: String
    let brandId: String
    let hasTimeshift: Bool
    let shortTitle: String
    let type: RadioType
    let streamUrl: String
    let analytics: Analytics
    let liveRule: String
    let colors: Colors
    let isMusical: Bool
    let assets: Assets?

    init(id: String,
         title: String,
         brandId: String,
         hasTimeshift: Bool,
         shortTitle: String ,
         type: RadioType,
         streamUrl: String,
         analytics: Analytics,
         liveRule: String,
         colors: Colors,
         isMusical: Bool,
         assets: Assets? = nil) {
        self.id = id
        self.title = title
        self.brandId = brandId
        self.hasTimeshift = hasTimeshift
        self.shortTitle = shortTitle
        self.type = type
        self.streamUrl = streamUrl
        self.analytics = analytics
        self.liveRule = liveRule
        self.colors = colors
        self.isMusical = isMusical
        self.assets = assets
    }
}
