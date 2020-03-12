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
    
    func addR(){
        addR(offset: 86400) // +1 day
    }
    
    func addR(offset: Double){
        let s = EKEventStore.init()
        s.requestAccess(to: EKEntityType.reminder) { (comp, e) -> Void in
            print(comp,e as Any)
            let r = EKReminder.init(eventStore: s)
            
            r.title = self.getEmoji() + " " + self.title
            r.notes = self.note
            
            let d = NSDate.init().addingTimeInterval(offset)
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
    
    
    func getEmoji() -> String {
        switch self.type {
            case .Touch: return "🖐️"
            case .Service: return "🔨"
            case .Words: return "📜"
            case .Time: return "🕰️"
            case .Gift: return "🎁"
        }
     }


    enum CodingKeys: String, CodingKey {
           case title = "title"
           case note = "note"
           case type = "type"
        }


}
