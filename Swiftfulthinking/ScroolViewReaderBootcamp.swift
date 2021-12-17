//
//  ScroolViewReaderBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 22/10/21.
//

import SwiftUI

struct ScroolViewReaderBootcamp: View {
    
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        
        VStack {
            
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                
                ScrollViewReader { proxy in
                    
//                    Button("CLICK HERE TO GO #49") {
//                        proxy.scrollTo(10,anchor: nil)
//                    }
//                    
                    ForEach(0..<20) { index in
                        Text("Hello, World!\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10.0)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)

                    }
                    .onChange(of: scrollToIndex, perform: { value in
                        withAnimation(.spring()){
                            proxy.scrollTo(value, anchor: .center)
                        }
                    })
                }
               
              
                
            }
        }
        
    }
}

struct ScroolViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScroolViewReaderBootcamp()
    }
}
