//
//  TimerBoocamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 26/10/21.
//

import SwiftUI

struct TimerBoocamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    // CURRENT DATE
//    @State var currentDate: Date = Date()
//    var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .medium
//        return formatter
//    }
    
    
    // COUNTDOWN
//    @State var count: Int = 10
//    @State var finishedText: String? = nil
    
    // COUNTDOWN TO DATE
//    @State var timerRemaining: String = ""
//    let futureDate: Date = Calendar.current.date(byAdding: .hour,value: 1,to: Date()) ?? Date()
    
//    func updateTimeRemaining() {
//        let remaining = Calendar.current.dateComponents([.minute,.second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
//        let minute = remaining.minute ?? 0
//        let second = remaining.second ?? 0
//
//        timerRemaining = "\(minute) minutes, \(second) seconds"
//    }
    
    // Animation Counter
    @State var count: Int = 0
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]),
                center: .center,
                startRadius: 5,
                endRadius: 500).ignoresSafeArea()
            
            
            
            TabView(selection: $count,
                    content:  {
                        Rectangle()
                            .foregroundColor(.red)
                            .tag(1)
                        Rectangle()
                            .foregroundColor(.gray)
                            .tag(2)
                        Rectangle()
                            .foregroundColor(.orange)
                            .tag(3)
                        Rectangle()
                            .foregroundColor(.green)
                            .tag(4)
                        Rectangle()
                            .foregroundColor(.pink)
                            .tag(5)
                    })
                .frame(height: 200)
                .tabViewStyle(PageTabViewStyle())
            
//            HStack(spacing: 20) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//
//            }
//            .frame(width: 200)
//            .foregroundColor(.white)
            
            
//            Text(timerRemaining)
//                .font(.system(size: 100,weight: .semibold,design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
        }
        .onReceive(timer, perform: { _ in
            
            withAnimation(.default) {
                count = count == 5 ? 0 : count + 1
            }
            
            
//            if count == 3 {
//                count = 0
//            } else {
//                count += 1
//            }
            
//            if count <= 1 {
//                finishedText = "Wow"
//            } else {
//                count -= 1
//            }
//            updateTimeRemaining()
        })
        
    }
}

struct TimerBoocamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBoocamp()
    }
}
