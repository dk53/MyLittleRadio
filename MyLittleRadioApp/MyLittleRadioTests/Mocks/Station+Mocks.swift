@testable import MyLittleRadio

extension Station {
    
    static let mock1 = Station(
        id: "1",
        title: "France Inter",
        brandId: "FRANCEINTER",
        hasTimeshift: true,
        shortTitle: "Inter",
        type: .onAir,
        streamUrl: "https://icecast.radiofrance.fr/franceinter-midfi.mp3",
        analytics: .init(value: "france_inter",
                         stationAudienceId: 3),
        liveRule: "apprf_inter_player",
        colors: .init(primary: "#e20134"),
        isMusical: false,
        assets: nil
    )
    
    static let mock2 = Station(
        id: "1",
        title: "Station Title 1",
        colors: Station.Colors(
            primary: "#FF5733"
        ),
        isMusical: true
    )
    
    static let mock3 = Station(
        id: "2",
        title: "Station Title 2",
        colors: Station.Colors(
            primary: "#33FF57"
        ),
        isMusical: false
    )
}
