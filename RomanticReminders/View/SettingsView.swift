//
//  SettingsView.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/16/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
   @State var lovePrefSettings = LovePrefSettingsViewModel()
   @State var showingReminderView = false
   @State var time = Date()

    
    var body: some View {
        VStack {
            Text("Settings").font(.largeTitle).padding(.top)
            
            ForEach(0 ..< self.lovePrefSettings.lovePrefs.count) {
                SettingView(s: self.$lovePrefSettings.lovePrefs[$0]).padding(.horizontal)
            }
            
            
            DatePicker(selection: self.$time, displayedComponents: .hourAndMinute){
                Text("")
            }
            
            
            
            Button(action: {
                // What to perform
                self.lovePrefSettings.save()
                self.showingReminderView.toggle()
                
            }) {
                // How the button looks like
                Text("Save")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(50)
            }.sheet(isPresented: self.$showingReminderView){
                ContentView(showingReminderView: self.$showingReminderView)
            }

            
        }.padding()
    }
}

struct SettingView:View {
    @Binding var s: LovePrefSettingViewModel
    
    var body: some View {
        HStack{
            Text(s.loveLang.getEmoji())
            
            Slider(value: self.$s.percentage, in: 0...100, step: 1)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
