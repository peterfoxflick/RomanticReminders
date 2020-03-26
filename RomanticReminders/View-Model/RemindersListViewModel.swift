//
//  RemindersListViewModel.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/6/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import Foundation
import EventKit


class RemindersListViewModel: ObservableObject, Identifiable {
    @Published var reminders = [ReminderViewModel]()

    init(){
        load()
    }
    
    //Thanks https://medium.com/@rbreve/displaying-a-list-with-swiftui-from-a-remote-json-file-6b4e4280a076
    func load() {
        let url = URL(string: "https://peterfoxflick.com/RomanticReminders.json")!
    
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([ReminderViewModel].self, from: d)
                    DispatchQueue.main.async {
                        self.sort(allItems: decodedLists)
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error: ", error)
            }
            
        }.resume()
    }
    
    func sort(allItems: [ReminderViewModel]){
        let days = settings.days
        
        var total = 0.0
        //First calc total
        for l in settings.lovePrefs {
            total += l.percentage
        }
        
        //Now sort out based on total
        for l in settings.lovePrefs {
            let portion = Int(l.percentage / total * Double(days))
            //get portion number of items from array
            
            var temp = allItems.filter { $0.type == l.loveLang }
            
            while(temp.count < portion) {
                temp.append(contentsOf: temp)
            }
            
            self.reminders.append(contentsOf: temp.shuffled()[0..<portion])
        }
    }
    
    func addAll(){
        let eventStore = EKEventStore()
        var cat = eventStore.defaultCalendarForNewReminders()

        do {
            cat = try self.reminderCategory()
        } catch {
          print("No clue but it didnt work...")
        }
        
        
        var day = 0
        self.reminders.forEach{ r in
            r.addR(offset: day, cal: cat!)
            day += 1
        }
    }
    
    
    //Thanks https://stackoverflow.com/questions/56727160/create-a-reminder-list-which-can-hold-your-reminders-in-the-reminders-app-that-y
    func reminderCategory() throws -> EKCalendar {
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .reminder)
        let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        if let bundleCalendar = calendars.first(where: {$0.title == bundleName}) { return bundleCalendar }

        let calendar = EKCalendar(for: .reminder, eventStore: eventStore)
        calendar.title = bundleName
        calendar.source = eventStore.defaultCalendarForNewReminders()?.source
        try eventStore.saveCalendar(calendar, commit: true)
        return calendar
    }}
