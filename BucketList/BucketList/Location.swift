//
//  Location.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/24/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID //this WAS let - but using var lets as change the UUID so we can create new locations!
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    //computed property for CLLocation2D
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude:latitude, longitude: longitude)
    }
    //You should make examples in your structs - it's a good practice and makes previewing it easier
    //The #if Debug is great for testing - it won't get compiled into a build!
#if DEBUG
    static let example = Location(id: UUID(), name: "New York City", description: "The Big Apple", latitude: 40.7, longitude: 74)
    
    static let example2 = Location(id: UUID(), name: "Buckingham Palace", description: "Lit by over 40,000 light bulbs", latitude: 51.501, longitude: -0.141)
#endif
    
    //this will make it equatable out of the box:
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
