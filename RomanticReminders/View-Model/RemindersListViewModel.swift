//
//  RemindersListViewModel.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/6/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation

class RemindersListViewModel: ObservableObject, Identifiable {
    @Published var reminders = [ReminderViewModel]()

    init(){
        reminders.append(ReminderViewModel(title:"Get Flowers", type: .Gift))
        reminders.append(ReminderViewModel(title:"Write a note", type: .Words))
        reminders.append(ReminderViewModel(title:"Hold hands", type: .Touch))
        reminders.append(ReminderViewModel(title:"Talk about your favorite date", type: .Time))
    }
}
