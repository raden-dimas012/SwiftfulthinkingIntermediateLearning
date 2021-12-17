//
//  BackgroundThreadBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 25/10/21.
//

import SwiftUI


class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.donwloadData()
            
            print("CHECK 1 : \(Thread.isMainThread)")
            print("CHECK 1 : \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                
                print("CHECK 2 : \(Thread.isMainThread)")
                print("CHECK 2 : \(Thread.current)")
            }
            
        }
        
    }
    
    private func donwloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                
                ForEach(vm.dataArray,id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
