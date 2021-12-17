//
//  TypeAliasBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 26/10/21.
//

import SwiftUI


struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

//struct TVModel {
//    let title: String
//    let director: String
//    let count: Int
//}

typealias TVModel = MovieModel

struct TypeAliasBootcamp: View {
    
    @State var item: MovieModel = MovieModel(title: "Title", director: "Joe", count: 5)
    
    @State var itemTV: TVModel = TVModel(title: "TV Title", director: "Joe", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

struct TypeAliasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypeAliasBootcamp()
    }
}
