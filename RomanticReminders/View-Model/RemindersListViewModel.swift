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
                        self.reminders = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error: ", error)
            }
            
        }.resume()
    }
    
    func addAll(){
        let offset = 0.0
        var day = 0.0
        
        self.reminders.forEach{ r in
            r.addR(offset: offset + day)
            day += 86400
        }
    }
}
