//
//  MultipleSheetsBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 22/10/21.
//

import SwiftUI



struct RandomModel: Identifiable {
    let id: String =  UUID().uuidString
    let title: String
}


// 1 - use a binding
// 2 - use multiple .sheets
// 3 - use $item

struct MultipleSheetsBootcamp: View {
    
//    @State var selectedModel: RandomModel = RandomModel(title: "Starting Title")
    
    @State var selectedModel: RandomModel? = nil
//    @State var showSheet: Bool = false
    
//    @State var selectedIndex: Int = 0
    
//    @State var showSheet2: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            
            ForEach(0..<20) { index in
                Button("Button \(index)") {
                    selectedModel = RandomModel(title: "\(index)")
                }
            }
            
//            Button("Button 1") {
//                selectedModel = RandomModel(title: "ONE")
//                showSheet.toggle()
//
//
//            }
//            .sheet(isPresented: $showSheet, content: {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))
//            })
//
//            Button("Button 2") {
//                selectedModel = RandomModel(title: "TWO")
//                showSheet2.toggle()
//
//
//            }
//            .sheet(isPresented: $showSheet2, content: {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            })
//
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
//        .sheet(isPresented: $showSheet, content: {
//            NextScreen(selectedModel: selectedModel)
//            if (selectedIndex == 1) {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))
//            } else if selectedIndex == 2 {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            } else {
//                NextScreen(selectedModel: RandomModel(title: "STARTING TITLE"))
//            }
//
//        })
    }
}


struct NextScreen: View {
    let selectedModel: RandomModel
//    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
