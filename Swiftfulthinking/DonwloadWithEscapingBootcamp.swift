//
//  DonwloadWithEscapingBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 26/10/21.
//

import SwiftUI


struct PostModel: Identifiable,Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}


class DownloadingWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        
        donwloadData(fromUrl: url) { (returnedData) in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self,from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
//                    self?.posts.append(newPosts)
                    self?.posts = newPosts
                }
            } else {
                print("No data returned.")
            }
        }
        
    }
    
    func donwloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                
                print("Error Donwloading Data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
                
//            guard let data = data else {
//                print("no data")
//                return
//            }
//
//            guard error == nil else {
//                print("Error: \(String(describing: error))")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("Invalid response...")
//                return
//            }
//
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Status code should be 2xx, but it is \(response.statusCode)")
//                return
//            }
            
//            print("SUCCESFULLY DONWLOADED DATA!")
//            print(data)
//            let jsonString = String(data: data,encoding: .utf8)
            
//            print(jsonString ?? "")
            

           
        }.resume()
    }
}



struct DonwloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadingWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
       
    }
}

struct DonwloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DonwloadWithEscapingBootcamp()
    }
}
