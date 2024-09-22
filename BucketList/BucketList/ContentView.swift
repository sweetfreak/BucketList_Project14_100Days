//
//  ContentView.swift
//  BucketList
//
//  Created by Jesse Sheehan on 9/22/24.
//

import SwiftUI

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
    
    */
    
    
//    func test() {
//        print(URL.documentsDirectory)
//    }
}

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
