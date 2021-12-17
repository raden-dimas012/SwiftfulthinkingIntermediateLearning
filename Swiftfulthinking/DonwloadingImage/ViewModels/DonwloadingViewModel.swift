//
//  DonwloadingViewModel.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import Foundation
import Combine

class DonwloadingViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] (returnedPhotoModels) in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
            
    }
}
