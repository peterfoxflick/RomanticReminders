//
//  setting.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/12/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation

class LovePrefSettingsViewModel: ObservableObject {
    @Published var lovePrefs: [LovePrefSettingViewModel]
    
    init(){
        self.lovePrefs = [LovePrefSettingViewModel]()
        LoveLang.allCases.forEach {
            let l = LovePrefSettingViewModel(loveLang: $0, percentage: 50.00)
            self.lovePrefs.append(l)
        }
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
}

