//
//  ArrayModificationBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 24/10/21.
//

import SwiftUI


struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool

}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUser()
        updatedFilteredArray()
    }
    
    func updatedFilteredArray() {
        // sort
//        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            return user1.points < user2.points
//        }
        
//        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
        
        
        // filter
//        filteredArray = dataArray.filter({ (user) -> Bool in
//            return user.isVerified
//        })
//        filteredArray = dataArray.filter({$0.isVerified})
        
        
        // map
//        mappedArray = dataArray.map({ (user)-> String in
//            return user.name ?? "ERROR"
//        })
        
//        mappedArray = dataArray.map({ $0.name})
        
//        mappedArray = dataArray.compactMap({ (user) -> String? in
//            return user.name
//        })
//
//        mappedArray = dataArray.compactMap({$0.name})
        
        
//        let sort = dataArray.sorted(by: {$0.points > $1.points})
//        let filter = dataArray.filter({$0.isVerified})
//        let map = dataArray.compactMap({$0.name})
        
        mappedArray = dataArray
                        .sorted(by: {$0.points > $1.points})
                        .filter({$0.isVerified})
                        .compactMap({$0.name})

        
        
    }
    
    func getUser() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 0, isVerified: false)
        let user3 = UserModel(name: nil, points: 20, isVerified: false)
        let user4 = UserModel(name: "Emily", points: 15, isVerified: true)
        let user5 = UserModel(name: "Samantha", points: 15, isVerified: true)
        let user6 = UserModel(name: "Jason", points: 25, isVerified: true)
        let user7 = UserModel(name: nil, points: 15, isVerified: false)
        let user8 = UserModel(name: "Lisa", points: 25, isVerified: true)
        let user9 = UserModel(name: "Steve", points: 15, isVerified: false)
        let user10 = UserModel(name: "Amanda", points: 15, isVerified: true)
        
        
        self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10
            ])
    }
    
    
}

struct ArrayModificationBootcamp: View {
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        
        
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
                
//                ForEach(vm.filteredArray) { data in
//                    LazyVStack(alignment: .leading) {
//                        Text(data.name)
//                        HStack {
//                            Text("Points: \(data.points)")
//
//                            Spacer()
//
//                            if data.isVerified {
//                                Image(systemName: "flame.fill")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                            }
//                        }
//
//                    }
//                    .foregroundColor(Color.white)
//                    .padding()
//                    .padding()
//                    .background(Color.blue.cornerRadius(10.0))
//                    .padding(.horizontal)
//
//
//                }
            }
        }
    }
}

struct ArrayModificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArrayModificationBootcamp()
    }
}
