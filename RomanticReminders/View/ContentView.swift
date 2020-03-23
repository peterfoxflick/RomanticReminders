//
//  ContentView.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/5/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var rlist = RemindersListViewModel()
    @Binding var showingReminderView: Bool
    
    
    var body: some View {
        VStack {
            Text("Romantic Reminders").font(.largeTitle).padding(.top)

            List{
                ForEach(self.rlist.reminders){ r in
                    HStack{
                        self.loveTypeImg(type: r.type)
                        Text(r.title)
                    }
                }
            }
            
            Button(action: {
                // What to perform
                self.rlist.addAll()
                self.showingReminderView.toggle()
                
            }) {
                // How the button looks like
                Text("Add reminder")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(50)
            }
              
        }
    }
    
    func loveTypeImg(type: LoveLang) -> Image {
       switch type {
           case .Touch: return Image(systemName: "hand.raised")
           case .Service: return Image(systemName: "hammer")
           case .Words: return Image(systemName: "message")
           case .Time: return Image(systemName: "clock")
           case .Gift: return Image(systemName: "gift")
           }
        }

}

//struct ContentView_Previews: PreviewProvider {
//    let showMe = true
//    static var previews: some View {
//        ContentView(show: showMe)
//    }
//}
