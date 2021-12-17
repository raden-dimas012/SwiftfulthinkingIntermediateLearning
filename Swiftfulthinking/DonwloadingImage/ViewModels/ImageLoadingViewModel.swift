//
//  ImageLoadingViewModel.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    let urlString: String
    let imageKey: String
    var cancellables = Set<AnyCancellable>()
    let manager = PhotoModelCacheManager.instance /* for saving data just for temporary when user use the app and this is will disappear when user kill the app, this manager consume more than memory  with filemanager */
    // let manager = PhotoModelFileManager.instance // for saving data to file manager low memory use but do not save everything in this manager
    
    init(url: String,key: String) {
        urlString = url
        imageKey = key
//        donwloadImage()
        getImage()
        
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            donwloadImage()
            print("Donwloading Image")
        }
        
    }
    
    
    func donwloadImage() {
        print("Donwloading Image Now! ")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self,
                      let image = returnedImage else { return }
                
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)

        
        
    }
    
    
    
}
