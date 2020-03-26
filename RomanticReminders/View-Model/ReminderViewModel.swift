//
//  ReminderViewModel.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/5/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation
import SwiftUI
import EventKit


class ReminderViewModel: ObservableObject, Identifiable, Decodable {
    var title: String
    var note: String?
    var type: LoveLang
    
    init(title: String, type:LoveLang, note:String = ""){
        self.title = title
        self.type = type
        self.note = note
    }
    
    
    func addR(offset: Int, cal: EKCalendar){
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: EKEntityType.reminder, completion: {
         granted, error in
         if (granted) && (error == nil) {
           print("granted \(granted)")


           let reminder:EKReminder = EKReminder(eventStore: eventStore)
            reminder.title = self.type.getEmoji() + " " + self.title

           reminder.notes = "...this is a note"

            var dateComponents = DateComponents()
            let theCalendar     = Calendar.current
            
            dateComponents.day = offset     //Number of days in future
            
            let reminderDay = theCalendar.date(byAdding: dateComponents, to: Date()) ?? Date()
            
            var triggerDate = Calendar.current.dateComponents([.day,.hour,.minute, .year, .month, .timeZone], from: reminderDay)
            triggerDate.hour = settings.getHour()
            triggerDate.minute = settings.getMinute()
            
            let reminderDate = theCalendar.date(from: triggerDate) ?? Date()

            
            

          // let alarmTime = Date().addingTimeInterval(1*60*24*3)
            let alarm = EKAlarm.init(absoluteDate: reminderDate)
           reminder.addAlarm(alarm)

           reminder.calendar = cal

           do {
             try eventStore.save(reminder, commit: true)
           } catch {
             print("Cannot save")
             return
           }
           print("Reminder saved")
         }
        })
    }

    enum CodingKeys: String, CodingKey {
           case title = "title"
           case note = "note"
           case type = "type"
        }


}
