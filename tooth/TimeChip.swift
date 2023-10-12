//
//  TimeChip.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 17..
//

import SwiftUI
import Foundation

struct TimeChip: View {
    @AppStorage("currentTheme") var currentTheme = "yellow"
    
    @Binding var notificationTimes: [Date]
    
    @State var date: Date
    
    
    func formatDateToTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        HStack {
            Text(formatDateToTime(date: date)).font(.headline).bold()
            Button {
                notificationTimes.remove(at: notificationTimes.firstIndex(of: date) ?? 0)
            } label: {
                Label("Add time", systemImage: "xmark.circle.fill").labelStyle(.iconOnly)
            }
        }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 10)).background(Color("ColorPalette_\(currentTheme)_tint")).cornerRadius(24)
    }
}

struct TimeChip_Previews: PreviewProvider {
    static var previews: some View {
        TimeChip(notificationTimes: .constant([]), date: Date())
    }
}

