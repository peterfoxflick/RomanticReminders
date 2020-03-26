//
//  lovePref.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/19/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation
let settings = SettingsDM()

class SettingsDM { // Data manager
    var lovePrefs = [LovePref]()
    var time = Date()
    var reminders = [UUID]()
    var days = Int()

    init(){
        fetch()
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        //Save love language percentages
        self.lovePrefs.forEach { l in
            defaults.set(l.percentage, forKey: l.loveLang.getText())
        }
        
        //Save time
        defaults.set(time, forKey: "time")
        
        //Save reminder ids
       // defaults.set(reminders, forKey: "reminderIDs")
        
        //save number of days pref
        defaults.set(days, forKey: "numberOfDays")
    }
    
    func fetch(){
        self.lovePrefs.removeAll()

        let defaults = UserDefaults.standard
        
        for loveLang in LoveLang.allCases {            
            let doubleLovePref = defaults.object(forKey: loveLang.getText()) as? Double ?? 50.00
            let lovePref = LovePref(loveLang: loveLang, percentage: doubleLovePref)
            self.lovePrefs.append(lovePref)

        }
        
        self.time = defaults.object(forKey: "time") as? Date ?? Date()
        
        self.reminders = defaults.object(forKey: "reminderIDs") as? [UUID] ?? [UUID]()
        
        self.days = defaults.object(forKey: "numberOfDays") as? Int ?? 14
    }
    
    func setLovePrefs(lovePrefs: [LovePref]){
        self.lovePrefs = lovePrefs
        save()
    }
    
    
    func getHour() -> Int{
        return Calendar.current.component(.hour, from: self.time)
    }
    
    func getMinute() -> Int{
        print(Calendar.current.component(.minute, from: self.time))

        return Calendar.current.component(.minute, from: self.time)
    }
}

class LovePref {
    let loveLang:LoveLang
    var percentage: Double
    let id: LoveLang
    
    init(loveLang: LoveLang, percentage: Double){
        self.loveLang = loveLang
        self.percentage = percentage
        self.id = loveLang
    }
}


