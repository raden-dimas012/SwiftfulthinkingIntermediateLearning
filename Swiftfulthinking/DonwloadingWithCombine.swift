//
//  DonwloadingWithCombine.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 26/10/21.
//

import SwiftUI
import Combine

struct PostModelCombine: Identifiable,Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadingWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModelCombine] = []
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine Discussion:
        /*
        // 1. sign up for monthly subsription for package to be delivered
        // 2. the company would make the package behind the scene
        // 3. receive the package at your front door
        // 4. make sure the box isn't damaged
        // 5. open and make sure the item is correct
        // 6. use the item!!!!
        // 7. cancellable at any time
        
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode (decode data into PostModels)
        // 6. sink (put the item into our app)
        // 7. store (cancel subsription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
//            .tryMap{ (data,response) -> Data in
//                guard
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .decode(type: [PostModelCombine].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnPosts) in
                self?.posts = returnPosts
            })
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("There was an error. \(error)")
//                }
//
//                print("COMPLETION: \(completion)")
//            } receiveValue: { [weak self] (returnedPosts) in
//                Thread.isMainThread
//                Thread.current
//                self?.posts = returnedPosts
//            }
            .store(in: &cancellables)

        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
}

struct DonwloadingWithCombine: View {
    @StateObject var vm = DownloadingWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
       
    }
}

struct DonwloadingWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DonwloadingWithCombine()
    }
}
