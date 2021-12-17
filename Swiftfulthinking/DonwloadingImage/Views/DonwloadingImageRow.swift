//
//  DonwloadingImageRow.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import SwiftUI

struct DonwloadingImageRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DonwloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity,  alignment: .leading)
        }
    }
}

struct DonwloadingImageRow_Previews: PreviewProvider {
    static var previews: some View {
        DonwloadingImageRow(model: PhotoModel(albumId: 1, id: 1, title: "Title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
