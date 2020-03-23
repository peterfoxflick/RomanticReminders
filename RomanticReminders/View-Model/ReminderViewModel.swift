//
//  ReminderViewModel.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/5/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation
import SwiftUI
import UserNotifications


class ReminderViewModel: ObservableObject, Identifiable, Decodable {
    var title: String
    var note: String?
    var type: LoveLang
    
    init(title: String, type:LoveLang, note:String = ""){
        self.title = title
        self.type = type
        self.note = note
    }
    
    func addR(){
        addR(offset: 86400) // +1 day
    }
    
    func addR(offset: Double){
        //Thanks to this https://www.hackingwithswift.com/books/ios-swiftui/scheduling-local-notifications
        // and this: https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app
        // and this: https://medium.com/quick-code/local-notifications-with-swift-4-b32e7ad93c2
        
        
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        //Check if the user has authorized notifications:
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
                return
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = self.type.getEmoji() + " " +  self.title
        content.body = self.note ?? ""
        content.badge = 1
        
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = 2  // Monday
        dateComponents.hour = 7    // 14:00 hours
        dateComponents.minute = 50
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
                
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        notificationCenter.add(request) { (error) in
           if error != nil {
            print("Error \(error!.localizedDescription)")
              // Handle any errors.
           }
        }
        
        print("UUID \(uuidString)")

    }

    enum CodingKeys: String, CodingKey {
           case title = "title"
           case note = "note"
           case type = "type"
        }


}
