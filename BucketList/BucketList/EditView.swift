//
//  EditView.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/24/24.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    @State private var name: String
    @State private var description: String
    var onSave: (Location) -> Void
    
    //loading + wikipedia stuff
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            
                            //pluses attach the views together with distinct text styles, but one text view!
                            + Text(": ") +
                            
                            Text(page.description)
                        }
                    case .failed:
                        Text("Please try again later")
                            .italic()

                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    //could use @Binding but that'll cause issues in ContentView.
                    //Simpler solution: require a function to call and passback the new information we want.
                    var newLocation = location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    //So, @State usually needs to have an initial value, but since we're getting those values from the Location, we need to initialize it so it has starting values
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        //NOTE: Swift wants to know if a function will be used straight away or not - here, we're stashing it away to use later. So we use "@escaping" (and a small memory cost) to tell swift to save it for later.
        
        //the underscores are important to make this work!
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
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

#Preview {
    EditView(location: .example) { _ in }
}
