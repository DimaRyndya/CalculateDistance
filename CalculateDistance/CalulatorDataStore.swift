import SwiftUI
import CoreLocation

final class CalculatorDataStore {
    let currentLocation = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
    var destinationLocation: CLLocationCoordinate2D?

    let APIKey = "AIzaSyCgJPLzCu6ZuGQWURT0L0BlxWTu6q0Ob9E"
    let baseURLString = "https://maps.googleapis.com/maps/api/distancematrix/json"
    var baseParams = [
        "destinations": "",
        "origins": "",
        "key": "",
    ]

    func getDestionationLocation(latitude: Double, longtitude: Double) {
        destinationLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }

    func updateBaseParams() {
        baseParams["destinations"] = "\(destinationLocation?.latitude ?? 0),\(destinationLocation?.longitude ?? 0)"
        baseParams["origins"] = "\(currentLocation.latitude),\(currentLocation.longitude)"
        baseParams["key"] = APIKey
    }

    func fetchContents() {
        guard var urlComponents = URLComponents(string: baseURLString) else { return }
        urlComponents.setQueryItems(with: baseParams)
        guard let contentsURL = urlComponents.url else { return }

        URLSession.shared.dataTask(with: contentsURL) { data, response, error in
            if let data = data,
                  let response = response as? HTTPURLResponse {
                  print(response.statusCode)
                  if let decodedResponse = try? JSONDecoder().decode(
                    Response.self, from: data) {
                    DispatchQueue.main.async {
                        print(decodedResponse.originAddress)
                        print(decodedResponse.destinationAddress)
//                        print(decodedResponse.distance)
//                        print(decodedResponse.duration)
                    }
                    return
                  }
                }
                print(
                  "Contents fetch failed: " +
                    "\(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}


