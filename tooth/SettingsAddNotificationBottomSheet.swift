//
//  SettingsAddNotificationBottomSheet.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 18..
//

import SwiftUI
import BottomSheet

struct SettingsAddNotificationBottomSheet: View {
    @State var date: Date
    @AppStorage("currentTheme") var currentTheme: String = "yellow"
    @Binding var position: BottomSheetPosition
    @Binding var notificationTimes: [Date]
    
    var body: some View {
        VStack {
            DatePicker("", selection: $date, displayedComponents: .hourAndMinute).labelsHidden().datePickerStyle(WheelDatePickerStyle())
            Button("Add Notification") {
                notificationTimes.append(date)
                position = .hidden
                
                createScrubNotification(date: date)
                
            }.buttonStyle(.borderedProminent).tint(Color("ColorPalette_\(currentTheme)_tint")).foregroundColor(Color("ColorPalette_\(currentTheme)_foreground"))
        }.padding([.bottom], 40)
            .onAppear {
                date = Date()
            }
    }
}

struct SettingsAddNotificationBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAddNotificationBottomSheet(date: Date(), currentTheme: "yellow", position: .constant(.hidden), notificationTimes: .constant([]))
    }
}
