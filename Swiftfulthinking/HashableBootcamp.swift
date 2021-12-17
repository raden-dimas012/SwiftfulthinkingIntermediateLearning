//
//  HashableBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 24/10/21.
//

import SwiftUI

struct MyCustomModel: Hashable { // if you don't want to use id you can use hashable
    //Identifiable {
//    let id = UUID().uuidString
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
                
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
//                ForEach(data) { item in
//                    Text(item.hashValue.description)
//                        .font(.headline)
//                    Text(item.title)
//                        .font(.headline)
                    
//                }
            }
        }
    }
}

struct HashableBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashableBootcamp()
    }
}
