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
        let textElements = try container.decode(ElementsText.self, forKey: .rows)
        distance = textElements.distance
        duration = textElements.duration
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

//    enum RowKeys: CodingKey {
//        case rows
//    }

    enum ElemKeys: String, CodingKey {
        case elements
    }

    enum ValuesKeys: String, CodingKey {
        case distance, duration
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ElemKeys.self)
//        let elementsContainer = try container.nestedContainer(keyedBy: ElemKeys.self, forKey: .rows)
        let valuesContainer = try container.nestedContainer(keyedBy: ValuesKeys.self, forKey: .elements)
//        let distanceContainer = try valuesContainer.nestedContainer(keyedBy: ValueKeys.self, forKey: .distance)
        let dist = try valuesContainer.decode(DistanceText.self, forKey: .distance)

        distance = dist.text
        let durationContainer = try valuesContainer.nestedContainer(keyedBy: ValuesKeys.self, forKey: .duration)
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
