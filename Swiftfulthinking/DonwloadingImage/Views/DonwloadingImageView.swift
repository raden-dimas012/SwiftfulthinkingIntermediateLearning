//
//  DonwloadingImageView.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import SwiftUI

struct DonwloadingImageView: View {
    
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String,key: String) {
        _loader = StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

struct DonwloadingImageView_Previews: PreviewProvider {
    static var previews: some View {
        DonwloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
