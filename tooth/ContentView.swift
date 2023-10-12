//
//  ContentView.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 04..
//

import SwiftUI
import EffectsLibrary
import BottomSheet
import HealthKit
import UserNotifications


func dateToString(date: Date) -> String {
    let now: Date = Date()
    if date.formatted(.dateTime.year()) != now.formatted(.dateTime.year()) {
        return String(date.formatted(.dateTime.year()))
    }
    else if date.formatted(.dateTime.month()) != now.formatted(.dateTime.month()) {
        return String(date.formatted(.dateTime.month()))
    }
    else if date.formatted(.dateTime.day()) != now.formatted(.dateTime.day()) {
        return String(date.formatted(.dateTime.month())) + " " + String(date.formatted(.dateTime.day()))
    }
    else {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: date)
    }
}


func secondsToHoursMinutesSeconds(_ seconds: Int) -> String {
    let (_, m, s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    return "\(m):\(s > 9 ? "\(s)" : "0\(s)")"
}


struct ContentView: View {
    @State var isTimerStarted: Bool = false
    @State var progress: Double = 0
    
    @State var healthSheetPosition: BottomSheetPosition = .hidden
    @State var bottomSheetPosition: BottomSheetPosition = .absolute(200)
    @State var notificationSheetPosition: BottomSheetPosition = .hidden
    
    @State var notificationTimes: [Date] = [Date(timeIntervalSince1970: 1674023400), Date(timeIntervalSince1970: 1672606800)]
    
    @AppStorage("showAnimations") var showAnimations: Bool = true
    @AppStorage("haptics") var haptics: Bool = true
    @AppStorage("timerLength") var timerLength: Double = 120
    @AppStorage("keepScreenAwake") var keepScreenAwake: Bool = true
    @AppStorage("lastScrubbed") var lastScrubbed: Int = 0
    @AppStorage("currentTheme") var currentTheme: String = "yellow"
    
    
    private let defaults: UserDefaults = UserDefaults.standard
    private let haptic = UINotificationFeedbackGenerator()
    
    private var healthStore: HealthStore?
    
    
    init() {
        healthStore = HealthStore()
    }
    
    
    let timerFunction = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    @State var startDate: Date = Date()
    
    func logBrush(startDate: Date, endDate: Date) {
        let sample = HKCategorySample(type: HKCategoryType(.toothbrushingEvent), value: HKCategoryValue.notApplicable.rawValue, start: startDate, end: endDate)
        healthStore?.healthStore?.save(sample, withCompletion: {_,_ in })
        lastScrubbed = Int(Date().timeIntervalSince1970)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                if isTimerStarted {
                    Spacer()
                }
                ZStack {
                    if showAnimations && isTimerStarted {
                        SmokeView(
                            config: SmokeConfig(
                                content: [
                                    .emoji("🫧", 2.0),
                                ],
                                intensity: .medium,
                                lifetime: .long,
                                initialVelocity: .fast,
                                fadeOut: .fast
                            )
                        ).opacity(isTimerStarted ? 1 : 0).animation(.easeInOut, value: isTimerStarted)
                    }
                    Circle().fill(.white).frame(width: 230, height: 230)
                    Circle()
                        .stroke( // 1
                            Color("ColorPalette_\(currentTheme)_tint"),
                            lineWidth: 15
                        ).frame(width: 215, height: 215)
                    Circle()
                    // 2
                        .trim(from: 0, to: progress)
                        .stroke(
                            .white,
                            style: StrokeStyle(
                                lineWidth: 15,
                                lineCap: .round
                            )
                        ).rotationEffect(.degrees(-90)).frame(width: 215, height: 215).animation(.easeOut, value: progress)
                    Button {
                        withAnimation {
                            isTimerStarted.toggle();
                        }
                        if (isTimerStarted) {
                            if (haptics) {
                                haptic.notificationOccurred(.success)
                            }
                            startDate = Date()
                            bottomSheetPosition = .hidden
                            UIApplication.shared.isIdleTimerDisabled = keepScreenAwake
                        } else {
                            if (haptics) {
                                haptic.notificationOccurred(.error)
                            }
                            if (Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate > 30.0) {
                                logBrush(startDate: startDate, endDate: Date())
                            }
                            bottomSheetPosition = .absolute(200)
                            UIApplication.shared.isIdleTimerDisabled = false
                        }
                        progress = 0
                    } label: {Text("🪥").font(.system(size: 125)).frame(width: 200, height: 200).background(Color("ColorPalette_\(currentTheme)_brush")).cornerRadius(.infinity)
                    }
                }.frame(minWidth: 1, idealWidth: .infinity, maxWidth: .infinity, minHeight: 350, idealHeight: 350, maxHeight: 350, alignment: .center).onReceive(timerFunction) { _ in
                    if (isTimerStarted && Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate < timerLength) {
                        progress = (Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate) / timerLength;
                    } else if (isTimerStarted) {
                        haptic.notificationOccurred(.success);
                        logBrush(startDate: startDate, endDate: Date())
                        isTimerStarted = false
                        bottomSheetPosition = .absolute(200)
                        UIApplication.shared.isIdleTimerDisabled = false
                    }
                }
                if isTimerStarted {
                    Spacer()
                }
                VStack {
                    Text(secondsToHoursMinutesSeconds(Int(isTimerStarted ? timerLength - (Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate) : timerLength))).font(.system(size: 80, weight: .black).width(.expanded))
                    Text("Tap the brush to start the timer.").font(.subheadline)
                }.padding(EdgeInsets(top: 50, leading: 0, bottom: isTimerStarted ? 100 : 0, trailing: 0))
                if !isTimerStarted {
                    Spacer(minLength: 150)
                }
                Text("Scrub").font(.largeTitle.width(.expanded)).bold()
            }.toolbar {
                if lastScrubbed != 0 {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Text("Last scrubbed:")
                            Text(dateToString(date: Date(timeIntervalSince1970: TimeInterval(lastScrubbed)) )).bold().font(.body.width(.expanded))
                        }
                    }
                };
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        healthSheetPosition = .dynamicTop
                    } label: {
                        Label("Apple Health", systemImage: "heart.text.square.fill").labelStyle(.titleOnly)
                    }.tint(.pink)
                }
            }.background(Color("ColorPalette_\(currentTheme)_background")).ignoresSafeArea(edges: [])
        }.preferredColorScheme(.light)
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [.absolute(200), .dynamicTop]) {
                BottomSheet(timerLength: $timerLength, isTimerStarted: $isTimerStarted, currentTheme: $currentTheme, showAnimations: $showAnimations, keepScreenAwake: $keepScreenAwake, haptics: $haptics, notificationSheetPosition: $notificationSheetPosition, notificationTimes: $notificationTimes)
            }.enableAppleScrollBehavior()
            .bottomSheet(bottomSheetPosition: $notificationSheetPosition, switchablePositions: [.hidden], headerContent: {
                VStack(alignment: .leading) {
                    Text("New Notification").font(.title.width(.expanded)).bold().padding([.top, .leading])
                }
            }) {
                SettingsAddNotificationBottomSheet(date: Date(), currentTheme: currentTheme, position: $notificationSheetPosition, notificationTimes: $notificationTimes)
            }.showCloseButton().showDragIndicator(false)
            .bottomSheet(bottomSheetPosition: $healthSheetPosition, switchablePositions: [.hidden], headerContent: {
                VStack(alignment: .leading) {
                    Text("Apple Health").font(.title.width(.expanded)).bold().padding([.top, .leading])
                }
            }) {
                AppleHealthSheet()
            }.showCloseButton().showDragIndicator(false).enableBackgroundBlur()
    }
    
    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.banner, .badge, .sound])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
