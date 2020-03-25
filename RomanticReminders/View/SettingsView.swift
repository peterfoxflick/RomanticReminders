//
//  SettingsView.swift
//  RomanticReminders
//
//  Created by Peter Flickinger on 3/16/20.
//  Copyright © 2020 Peter Flickinger. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
   @ObservedObject var lovePrefSettings = LovePrefSettingsViewModel()
   @State var showingReminderView = false

    @State var quantity: Int = 0

    var body: some View {
        VStack {
            Text("Settings").font(.largeTitle).padding(.top)
            
            //Love Lang Percentages
            ForEach(0 ..< self.lovePrefSettings.lovePrefs.count) {
                SettingView(s: self.$lovePrefSettings.lovePrefs[$0]).padding(.horizontal)
            }
            
            //Number of days
            Stepper("Number of days: \(self.lovePrefSettings.days)", value: self.$lovePrefSettings.days, in: 1...14)

            
            // Time of day for reminder
            DatePicker(selection: self.$lovePrefSettings.time, displayedComponents: .hourAndMinute){
                Text("")
            }
            
            
            //Save button
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
