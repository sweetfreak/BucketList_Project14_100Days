//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/25/24.
//
import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location] //doesn't need to be initialized with = and () anymore -init below
        var selectedPlace: Location?
        var isUnlocked = false
        
        var authenticationError = "Unknown Error"
        var isShowingAuthenticationError = false
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
             locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else {return}
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        //error
                        self.authenticationError = "There was a problem authentication you; please try again."
                        self.isShowingAuthenticationError = true
                    }
                }
            } else {
                //no biometrics
                authenticationError = "Sorry, your device does not support biometric authentication."
                isShowingAuthenticationError = true
            }
        }
        
    }
}



