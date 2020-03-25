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
       // let offset = 0.0
      //  var day = 0.0
        print("Call Addall()")
        
        self.reminders[0].addR()
        
//        self.reminders.forEach{ r in
//            r.addR(offset: offset + day)
//            day += 86400
//        }
    }
}
