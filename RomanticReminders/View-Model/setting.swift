//
//  setting.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/12/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation

struct LovePref {
    let loveLang:LoveLang
    let percentage: Double
}

class Setting {
    var loveLangPercent: [LovePref]
    
    init(){
        self.loveLangPercent = [LovePref]()
        LoveLang.allCases.forEach {
            let l = LovePref(loveLang: $0, percentage: 100.00)
            self.loveLangPercent.append(l)
        }
    }
}
