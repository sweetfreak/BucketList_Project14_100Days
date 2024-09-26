//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/26/24.
//

import SwiftUI

extension EditView {
    @Observable
    class ViewModel {
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location
        
        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages = [Page]()

        init(location: Location) {
            name = location.name
            description = location.description
            self.location = location
        }
        
        func createNewLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from:url)
                let items = try JSONDecoder().decode(Result.self, from:data)
                pages = items.query.pages.values.sorted() //{ $0.title < $1.title }
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
        
        
        
    }
}
