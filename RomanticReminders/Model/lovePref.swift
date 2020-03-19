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

    init(){
        fetch()
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        lovePrefs.forEach { l in
            defaults.set(l.percentage, forKey: l.loveLang.getText())
        }
    }
    
    func fetch(){
        self.lovePrefs.removeAll()

        let defaults = UserDefaults.standard

        LoveLang.allCases.forEach{
            let doubleLovePref = defaults.object(forKey: $0.getText()) as? Double ?? 50.00
            let lovePref = LovePref(loveLang: $0, percentage: doubleLovePref)
            self.lovePrefs.append(lovePref)
        }
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


