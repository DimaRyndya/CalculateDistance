import SwiftUI

struct Response {
    var originAddress: [String] = []
    var destinationAddress: [String] = []
    var distance = ""
    var duration = ""

    init?(from dictionary: [String: Any]) {
        guard let rowsDictionary = dictionary["rows"] as? [[String: Any]],
              let elementsDictionary = rowsDictionary.first?["elements"] as? [[String: Any]],
              let distanceDictionary = elementsDictionary.first?["distance"] as? [String: Any],
              let durationDictionary = elementsDictionary.first?["duration"] as? [String: Any],
              let distanceMeters = distanceDictionary["text"] as? String,
              let durationSeconds = durationDictionary["text"] as? String
        else {
            return nil
        }
        
        distance = distanceMeters
        duration = durationSeconds
    }
}

extension Response: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        originAddress = try container.decode([String].self, forKey: .originAddress)
        destinationAddress = try container.decode([String].self, forKey: .destinationAddress)
    }
}

    enum CodingKeys: String, CodingKey {
        case originAddress = "origin_addresses"
        case destinationAddress = "destination_addresses"
    }

