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

class ReminderViewModel: ObservableObject, Identifiable {
    var title: String
    var type: LoveLang
    
    init(title: String, type:LoveLang){
        self.title = title
        self.type = type
    }
    
    func addR(){
        let s = EKEventStore.init()
        s.requestAccess(to: EKEntityType.reminder) { (comp, e) -> Void in
            print(comp,e as Any)
            let r = EKReminder.init(eventStore: s)
            r.title = self.title
            let d = NSDate.init().addingTimeInterval(60)
            let a = EKAlarm.init(absoluteDate: d as Date)
            r.calendar = s.defaultCalendarForNewReminders()
            r.addAlarm(a)
            do{
                try s.save(r, commit: true)
                print(r, "saved")
            } catch {
                print("couldnt save")
            }
        }
    }

}
