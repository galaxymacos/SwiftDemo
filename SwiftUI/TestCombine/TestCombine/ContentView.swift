//
//  ContentView.swift
//  TestCombine
//
//  Created by Xun Ruan on 2021/7/24.
//

import SwiftUI

// Models
struct User: Decodable, Identifiable{
    let id: Int
    let name: String
}

// View Models
import Combine

class ViewModel: ObservableObject{
    @Published var time = ""
    @Published var users = [User]()
    
    // keep the subscriber alive
    private var cancellables = Set<AnyCancellable>()
    
    
    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()
    
    init() {
        setupPublisher()
    }
    
    func setupPublisher(){
        setupTimePublisher()
        setupDateTaskPublisher()
    }
    
    func setupTimePublisher(){
        // This will publish (Data, error)
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            // Receive the information in the main queue
            .receive(on: RunLoop.main)
            .sink{ value in
                self.time = self.formatter.string(from: value)
            }
            .store(in: &cancellables)
    }
    
    func setupDateTaskPublisher(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        URLSession.shared.dataTaskPublisher(for: url)
            // Response contains the description of the response, like "is the request successful", etc
            // Data is the actually data ready to be decoded
            .tryMap{ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{throw URLError(.badServerResponse)}
                return data
            }
            .receive(on: DispatchQueue.main)
            // Processing the published value
            .decode(type: [User].self, decoder: JSONDecoder())
            // what to do after getting the published value - store them
            .sink(receiveCompletion: { _ in }){ users in
                self.users = users
            }
            // store the reference of the subscriber, keeping it alive out of the closure
            .store(in: &cancellables)
    }
}

// View
struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            Text(viewModel.time)
            List(viewModel.users){ user in
                Text(user.name)
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
