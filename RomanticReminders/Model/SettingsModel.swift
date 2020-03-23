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
    }
    
    func setLovePrefs(lovePrefs: [LovePref]){
        self.lovePrefs = lovePrefs
        save()
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


