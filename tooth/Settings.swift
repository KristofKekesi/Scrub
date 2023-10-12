//
//  Settings.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 10..
//

import SwiftUI
import BottomSheet


extension Bundle {
    var iconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
}


struct AppIcon: View {
    var body: some View {
        Bundle.main.iconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0) }
    }
}


struct Settings: View {
    @Binding var timerLength: Double
    @Binding var isTimerStarted: Bool
    
    @Binding var currentTheme: String
    @Binding var showAnimations: Bool
    @Binding var haptics: Bool
    @Binding var keepScreenAwake: Bool
    
    @Binding var notificationSheetPosition: BottomSheetPosition
    @Binding var notificationTimes: [Date]
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack() {
                    Text("Settings")
                    Spacer()
                }.font(.title.width(.expanded)).bold()
            }
            Group {
                HStack(alignment: .bottom) {
                    Text("Timer length :").font(.headline)
                    Text(secondsToHoursMinutesSeconds(Int(timerLength))).font(.system(size: 20, weight: .black).width(.expanded)).animation(.none)
                }.padding([.top], 5)
                HStack {
                    Text("1:30").font(.caption)
                    Slider(value: $timerLength, in: 90...150, step: 1).tint(Color("ColorPalette_\(currentTheme)_tint")).onChange(of: timerLength, perform: {newValue in
                        timerLength = newValue;
                    }).disabled(isTimerStarted)
                    Text("2:30").font(.caption)
                }.font(.caption)
            }.padding([.bottom])
            Group {
                HStack {
                    Text("Themes").font(.system(size: 20, weight: .black).width(.expanded))
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ThemePicker(currentTheme: $currentTheme, theme: "yellow")
                        ThemePicker(currentTheme: $currentTheme, theme: "orange")
                        ThemePicker(currentTheme: $currentTheme, theme: "indigo")
                    }
                }
            }.padding([.bottom])
            Group {
                HStack {
                    Text("Notifications").font(.system(size: 20, weight: .black).width(.expanded))
                    Spacer()
                }
                HStack {
                    AppIcon()
                        .frame(width: 50, height: 50).cornerRadius(10).padding()
                    VStack(alignment: .leading) {
                        Text("Scrub").font(.headline).bold()
                        Text("It's 8:00. Time to Scrub!")
                    }.foregroundColor(Color("ColorPalette_\(currentTheme)_foreground"))
                    Spacer()
                }.frame(height: 75).background(Color("ColorPalette_\(currentTheme)_tint")).cornerRadius(24)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(notificationTimes, id: \.self) { date in
                            TimeChip(notificationTimes: $notificationTimes, date: date)
                        }
                        Button {
                            let center = UNUserNotificationCenter.current()
                            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                
                                if error != nil {
                                    print(error as Any)
                                }
                            }
                            notificationSheetPosition = .dynamicTop
                        } label: {
                            Label("New srub notification", systemImage: "plus").labelStyle(.iconOnly)
                        }.padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)).background(Color("ColorPalette_\(currentTheme)_tint")).cornerRadius(24)
                    }
                }.foregroundColor(Color("ColorPalette_\(currentTheme)_foreground"))
                Divider()
                HStack {
                    AppIcon()
                        .frame(width: 50, height: 50).cornerRadius(10).padding()
                    VStack(alignment: .leading) {
                        Text("It's been 4 months").font(.headline).bold()
                        Text("Time for a new brush!")
                    }.foregroundColor(Color("ColorPalette_\(currentTheme)_foreground"))
                    Spacer()
                }.frame(height: 75).background(Color("ColorPalette_\(currentTheme)_tint")).cornerRadius(24)
                DatePicker("First use of current Brush", selection: .constant(Date()),
                           displayedComponents: [.date]).bold().font(.headline)
                    .preferredColorScheme(.light)
                Divider()
                Toggle("Enable Scrub notifications", isOn: .constant(false)).bold().font(.headline).disabled(true)
                VStack(alignment: .leading) {
                    Toggle("Enable Weekly notifications", isOn: .constant(false)).bold().font(.headline).disabled(true)
                    Text("Get notifications when it's time to replace your old brush.".uppercased()).font(.caption).foregroundColor(.gray).bold()
                }
                VStack(alignment: .leading) {
                    Toggle("Enable Weekly notifications", isOn: .constant(false)).bold().font(.headline).disabled(true)
                    Text("Get weekly recaps on Mondays to keep you motivated.".uppercased()).font(.caption).foregroundColor(.gray).bold()
                }
            }.tint(Color("ColorPalette_\(currentTheme)_tint")).padding([.bottom])
            Group {
                HStack {
                    Text("Other Options").font(.system(size: 20, weight: .black).width(.expanded))
                    Spacer()
                }
                Toggle("Show animations", isOn: $showAnimations.animation()).bold().font(.headline)
                Toggle("Haptics", isOn: $haptics).bold().font(.headline)
                Toggle("Keep screen awake", isOn: $keepScreenAwake).bold().font(.headline)
            }.tint(Color("ColorPalette_\(currentTheme)_tint"))
            Divider()
        }.padding([.bottom])
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(timerLength: .constant(120), isTimerStarted: .constant(true), currentTheme: .constant("yellow"), showAnimations: .constant(true), haptics: .constant(true), keepScreenAwake: .constant(true), notificationSheetPosition: .constant(.dynamicTop), notificationTimes: .constant([]))
    }
}
