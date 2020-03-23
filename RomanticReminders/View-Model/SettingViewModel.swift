//
//  setting.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/12/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation

class LovePrefSettingsViewModel: ObservableObject {
    @Published var lovePrefs = [LovePrefSettingViewModel]()
    @Published var time = Date()
    
    init(){
        fetch()
    }
    
    func fetch() {
        lovePrefs.removeAll()
        settings.fetch()
        
        let lovePrefsCore = settings.lovePrefs
        lovePrefsCore.forEach{ l in
            let lp = LovePrefSettingViewModel(lovePref: l)
            self.lovePrefs.append(lp)
        }
    }
    
    func save() {
        var coreLovePrefs = [LovePref]()
        self.lovePrefs.forEach{ l in
            let lovePref = LovePref(loveLang: l.loveLang, percentage: l.percentage)
            coreLovePrefs.append(lovePref)
        }
        settings.setLovePrefs(lovePrefs: coreLovePrefs)
    }
}


class LovePrefSettingViewModel: ObservableObject, Identifiable {
    @Published var loveLang:LoveLang
    @Published var percentage: Double
    let id: LoveLang
    
    init(loveLang: LoveLang, percentage: Double){
        self.loveLang = loveLang
        self.percentage = percentage
        self.id = loveLang
    }
    
    init(lovePref: LovePref){
        self.loveLang = lovePref.loveLang
        self.percentage = lovePref.percentage
        self.id = lovePref.loveLang
    }
    
}

