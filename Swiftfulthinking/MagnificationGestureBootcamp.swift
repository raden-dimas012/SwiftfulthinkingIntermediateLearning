//
//  MagnificationGestureBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 22/10/21.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State var currentAmount: CGFloat = 0.0
    @State var lastAmount: CGFloat = 0.0
    
    var body: some View {
        
        VStack {
            
            
            
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            
            Rectangle().frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("This is caption for your photo ")
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            
            
            
            
            
        }
        
        
//        Text("Hello, World!")
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10.0))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { value in
//                        currentAmount = value - 1
//                    }
//                    .onEnded { value in
//                        lastAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
    }
}

struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
