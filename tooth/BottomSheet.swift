//
//  BottomSheet.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 09..
//

import SwiftUI
import BottomSheet

struct BottomSheet: View {
    @Binding var timerLength: Double
    @Binding var isTimerStarted: Bool
    
    @Binding var currentTheme: String
    @Binding var showAnimations: Bool
    @Binding var keepScreenAwake: Bool
    @Binding var haptics: Bool
    
    @State var activeView: String = "settings"
    
    @Binding var notificationSheetPosition: BottomSheetPosition
    @Binding var notificationTimes: [Date]
    
    var body: some View {
        VStack(alignment: .leading) {
            Settings(timerLength: $timerLength, isTimerStarted: $isTimerStarted, currentTheme: $currentTheme, showAnimations: $showAnimations, haptics: $haptics, keepScreenAwake: $keepScreenAwake, notificationSheetPosition: $notificationSheetPosition, notificationTimes: $notificationTimes)
            Credit()
            About()
            HStack {
                Spacer()
                VStack {
                    Text("Made by @KristofKekesi")
                    Text("With love from 🇭🇺")
                }
                Spacer()
            }
        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)).padding()
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(timerLength: .constant(120), isTimerStarted: .constant(false), currentTheme: .constant("currentTheme"), showAnimations: .constant(true), keepScreenAwake: .constant(true), haptics: .constant(true), notificationSheetPosition: .constant(.hidden), notificationTimes: .constant([]))
    }
}
