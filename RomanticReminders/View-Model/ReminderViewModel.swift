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
        
        
        // Configure the recurring date.  Thanks: https://stackoverflow.com/questions/5067785/how-do-i-add-1-day-to-an-nsdate
        var dateComponents = DateComponents()
        let theCalendar     = Calendar.current
        
        dateComponents.day = 1     //Number of days in future
        
        let reminderDay = theCalendar.date(byAdding: dateComponents, to: Date())

        dateComponents.hour = 7
        dateComponents.minute = 50
        
        let triggerDate = Calendar.current.dateComponents([.day,.hour,.minute], from: Date())


           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
                
        let reminderID = UUID()
        let request = UNNotificationRequest(identifier: reminderID.uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system
        notificationCenter.add(request) { (error) in
           if error != nil {
            print("Error \(error!.localizedDescription)")
              // Handle any errors.
           }
        }
        
        //Save the id
        settings.reminders.append(reminderID)
    }

    enum CodingKeys: String, CodingKey {
           case title = "title"
           case note = "note"
           case type = "type"
        }


}
