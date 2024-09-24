//
//  ContentView.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/22/24.
//
import LocalAuthentication
import SwiftUI
//import MapKit

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked!")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    //authenticated successfully
                    isUnlocked = true
                } else {
                    //failed - need to have an alert or enter pin or something now - apple doesn't provide this part.
                }
                
            }
        } else {
            //no biometrics found
        }
    }
}

/*
struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    let locations = [
        Location(name:"Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
        Location(name:"Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508889, longitude: -0.076))
    ]
    
   @State private var  position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        
        VStack {
            MapReader { proxy in
                    Map()
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                print(coordinate)
                            }
                        }
            }
          
            
            
//            Map {
//                ForEach(locations) { location in
//                    //Marker(location.name, coordinate: location.coordinate)
//                    Annotation(location.name, coordinate: location.coordinate) {
//                        Text(location.name)
//                            .font(.headline)
//                            .padding()
//                            .background(.blue.gradient)
//                            .foregroundStyle(.white)
//                            .clipShape(.capsule)
//                    }
//                    .annotationTitles(.hidden)
//                }
//            }
        }
        
//        Map(position: $position,
//            interactionModes: [.rotate, .zoom]) // [])
//           //.mapStyle(.hybrid(elevation: .realistic))
//            .onMapCameraChange(frequency: .continuous) {context in
//                print(context.region)
//            }
        
//        HStack(spacing: 50) {
//            Button("London") {
//                position = MapCameraPosition.region(
//                    MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//                )
//            }
//            Button("Paris") {
//                position = MapCameraPosition.region(
//                    MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3533), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//                )
//            }
//            
//            Button("Tokyo") {
//                position = MapCameraPosition.region(
//                    MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//                )
//            }
//        }
    }
}
*/


/* Day 68 - using enums to change views

//these COULD be inside the ContentView, if you need them to, but depends on the side of the app
struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed!")
    }
}

struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        
//        if loadingState == .loading {
//            LoadingView()
//        } else if LoadingState.success == .success {
//            SuccessView()
//        } else if loadingState.failed == .failed {
//            FailedView()
//        }
        
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
        
        
//        if Bool.random() {
//            Rectangle()
//        } else {
//            Circle()
//        }

}
    */
    
    

/* // 68 - Read and Write data with documents directory
 //This lets you write a data file, like txt with your data, instead of using swiftData or the internet or UserDefaults
struct ContentView: View {
    var body: some View {
         
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url, encoding: .utf8)
                print(input)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    

    
    
//    func test() {
//        print(URL.documentsDirectory)
//    }
}
 
 */

/* //DAY 68 - making structs comparable by using one of their properties
 
struct User: Comparable, Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    
    let users = [
        User(firstName: "Joe", lastName: "Schmo"),
        User(firstName: "Rob", lastName: "Lowe"),
        User(firstName: "Jane", lastName: "Doe")
    ]
        .sorted() // { $0.lastName < $1.lastName} //this gets messy!!
    
    
    
    let values = [1,5,3,6,2,9].sorted()
    var body: some View {
//        List(values, id: \.self) {
        List(users) { user in
            //Text(String($0))
            Text("\(user.lastName), \(user.firstName)")
        }
        .padding()
    }
}
 */

#Preview {
    ContentView()
}
