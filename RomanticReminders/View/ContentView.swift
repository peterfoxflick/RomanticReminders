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
    
    var body: some View {
        VStack {
            Text("Romantic Reminders").font(.largeTitle)

            List{
                ForEach(self.rlist.reminders){ r in
                    HStack{
                        Text(r.title)
                        
                        
                        self.loveTypeImg(type: r.type)
                        
                        
                    }
                }
            }
            
            Button(action: {
                // What to perform
                //self.r.addR()
            }) {
                // How the button looks like
                Text("Add reminder")
            }
            
        }
    }
    
    func loveTypeImg(type: LoveLang) -> Image {
       switch type {
           case .Touch: return Image(systemName: "hand.raised")
           case .Service: return Image(systemName: "checkmark.circle")
           case .Words: return Image(systemName: "checkmark.circle")
           case .Time: return Image(systemName: "checkmark.circle")
           case .Gift: return Image(systemName: "checkmark.circle")
           }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
