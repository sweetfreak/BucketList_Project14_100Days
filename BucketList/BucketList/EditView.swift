//
//  EditView.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/24/24.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    @State private var name: String
    @State private var description: String
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
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
}

#Preview {
    EditView(location: .example) { _ in }
}
