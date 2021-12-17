//
//  DonwloadingImageBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//


// background threads
// weak self
// combine
// publisher and subscribers
// file manager
// NSCache

import SwiftUI

struct DonwloadingImageBootcamp: View {
    @StateObject var vm = DonwloadingViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DonwloadingImageRow(model: model)
                }
            }
            .navigationTitle("Donwloading bootcamp")
        }
    }
}

struct DonwloadingImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DonwloadingImageBootcamp()
    }
}
