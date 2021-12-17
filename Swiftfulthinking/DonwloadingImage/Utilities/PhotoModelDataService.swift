//
//  PhotoModelDataService.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    @Published var photoModels: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error Downloading Data.\(error)")
                }
            } receiveValue: { [weak self] (returnPhotoModels) in
                self?.photoModels = returnPhotoModels
            }
            .store(in: &cancellables)

        
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else { throw URLError(.badServerResponse) }
        
        return output.data
    }
    
    
}
