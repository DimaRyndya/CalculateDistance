import SwiftUI

struct Response {
    var originAddress: [String] = []
    var destinationAddress: [String] = []
    var distance = ""
    var duration = ""
}

extension Response: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        originAddress = try container.decode([String].self, forKey: .originAddress)
        destinationAddress = try container.decode([String].self, forKey: .destinationAddress)
        let elementsContainer = try container.nestedContainer(keyedBy: ElemKeys.self, forKey: .rows)
        let valuesContainer = try elementsContainer.nestedContainer(keyedBy: ValuesKeys.self, forKey: .elements)
        let distanceContainer = try valuesContainer.nestedContainer(keyedBy: DistanceKeys.self, forKey: .distance)
        distance = try distanceContainer.decode(String.self, forKey: .text)
        let durationContainer = try valuesContainer.nestedContainer(keyedBy: DurationKeys.self, forKey: .duration)
        duration = try durationContainer.decode(String.self, forKey: .text)
    }

    enum CodingKeys: String, CodingKey {
        case originAddress = "origin_addresses"
        case destinationAddress = "destination_addresses"
        case rows
    }

    enum ElemKeys: String, CodingKey {
        case elements
    }

    enum ValuesKeys: String, CodingKey {
        case distance, duration
    }

    enum DistanceKeys: String, CodingKey {
        case text
    }

    enum DurationKeys: String, CodingKey {
        case text
    }
}
