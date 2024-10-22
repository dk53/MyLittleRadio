// Copyright © Radio France. All rights reserved.

import Foundation

struct Station: Codable, Equatable, Identifiable {

    struct Analytics: Codable, Equatable {
        let value: String
        let stationAudienceId: Int
    }

    struct Colors: Codable, Equatable {
        let primary: String
    }

    struct Assets: Codable, Equatable {
        let squareImageUrl: String?
    }

    enum RadioType: Codable {
        case onAir
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

    init(id: String = "",
         title: String = "",
         brandId: String = "",
         hasTimeshift: Bool = false,
         shortTitle: String = "",
         type: RadioType = .onAir,
         streamUrl: String = "",
         analytics: Analytics = Analytics(value: "", stationAudienceId: Int.random(in: 1...14)),
         liveRule: String = "",
         colors: Colors = Colors(primary: ""),
         isMusical: Bool = false,
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
