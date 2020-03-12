//
//  enums.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/6/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation

enum LoveLang: Decodable, CaseIterable {
    init(from decoder: Decoder) throws {
        //https://stackoverflow.com/questions/44580719/how-do-i-make-an-enum-decodable-in-swift-4/44582674
        let label = try decoder.singleValueContainer().decode(String.self)
        switch label {
            case "Touch": self = .Touch
            case "Service": self = .Service
            case "Words": self = .Words
            case "Time": self = .Time
            case "Gift": self = .Gift
            default: self = .Service
        }
    }
    
    case Touch, Service, Words, Time, Gift
}
