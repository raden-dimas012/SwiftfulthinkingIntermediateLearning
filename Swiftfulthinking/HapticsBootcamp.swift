//
//  HapticsBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 22/10/21.
//

import SwiftUI


class HapticManager {
    static let instance = HapticManager() // singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType ) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("success") {
                HapticManager.instance.notification(type: .success)
            }
            Button("warning") {
                HapticManager.instance.notification(type: .warning)
            }
            Button("error") {
                HapticManager.instance.notification(type: .error)
            }
            Button("soft") {
                HapticManager.instance.impact(style: .soft)
            }
            Button("light") {
                HapticManager.instance.impact(style: .light)
            }
         
            Button("medium") {
                HapticManager.instance.impact(style: .medium)
            }
         
            Button("rigid") {
                HapticManager.instance.impact(style: .rigid)
            }
            
            Button("heavy") {
                HapticManager.instance.impact(style:.heavy)
            }
            
         
         
            
            
            
            
        }
    }
}

struct HapticsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsBootcamp()
    }
}
