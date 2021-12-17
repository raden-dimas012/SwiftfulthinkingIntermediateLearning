//
//  LocalNotificationBootcamp.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 24/10/21.
//

import SwiftUI
import UserNotifications
import CoreLocation


class NotificationManager {
    static let instance = NotificationManager() // singleton
    
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success,error) in
            
            if let error = error {
                print ("ERROR\(error)")
            } else {
                print("SUCCESS")
            }
            
        }
    }
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        
        content.title = "This is my first notification!"
        content.subtitle = "This was so easy!"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.9, repeats: false)
        
        //calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 28


        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,repeats: true)
        
        
        //location
//        let coordinate = CLLocationCoordinate2D(latitude: 40.0, longitude: 50.0)
//
//
//        let region = CLCircularRegion(center: coordinate, radius: 100, identifier: UUID().uuidString)
//
//        region.notifyOnEntry = true
//        region.notifyOnExit = false
//
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear() {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
