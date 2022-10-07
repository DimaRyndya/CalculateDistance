import SwiftUI
import CoreLocation

struct DistanceCalculatorView: View {
    @State private var latitude = ""
    @State private var longtitude = ""

    let dataStore = CalculatorDataStore()

    var body: some View {
        VStack {
            HStack {
                Text("Latitude: ")
                Spacer()
                TextField("Enter latutide", text: $latitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 260)
            }
            HStack {
                Text("Longtitude: ")
                Spacer()
                TextField("Enter longtitude", text: $longtitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 260)
            }
            Button("Calculate") {
                dataStore.getDestionationLocation(latitude: Double(latitude) ?? 0, longtitude: Double(longtitude) ?? 0)
                dataStore.updateBaseParams()
                dataStore.fetchContents()
                
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DistanceCalculatorView()
    }
}
