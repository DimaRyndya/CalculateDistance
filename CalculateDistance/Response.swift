import SwiftUI

struct Response {
    var originAddress = ""
    var destinationAddress = ""
    var distance = ""
    var duration = ""
}


extension Response: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        originAddress = try container.decode(String.self, forKey: .originAddress)
        destinationAddress = try container.decode(String.self, forKey: .destinationAddress)
    }


    enum CodingKeys: String, CodingKey {
        case originAddress = "origin_addresses"
        case destinationAddress = "destination_addresses"
        case rows
        case status
    }
}

struct ElementsText {
    var distance: String
    var duration: String
}

extension ElementsText: Decodable {

    enum CodingKeys: CodingKey {
        case rows
    }

    enum RowsKeys: String, CodingKey {
        case elements
    }

    enum ElemKeys: String, CodingKey {
        case distance, duration
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rowsContainer = try container.nestedContainer(keyedBy: RowsKeys.self, forKey: .rows)
        let elementContainer = try rowsContainer.nestedContainer(keyedBy: ElemKeys.self, forKey: .elements)
        let distanceContainer = try elementContainer.nestedContainer(keyedBy: ElemKeys.self, forKey: .distance)
        let dist = try distanceContainer.decode(DistanceText.self, forKey: .distance)
        distance = dist.text
        let durationContainer = try elementContainer.nestedContainer(keyedBy: ElemKeys.self, forKey: .duration)
        let dur = try durationContainer.decode(DurationText.self, forKey: .duration)
        duration = dur.text
    }
}

struct DistanceText: Codable {
    var text: String
}

struct DurationText: Codable {
    var text: String
}
