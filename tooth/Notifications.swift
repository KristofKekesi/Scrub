//
//  Notifications.swift
//  Scrub iOS
//
//  Created by Kristóf Kékesi on 2023. 04. 19..
//

import Foundation
import NotificationCenter

// Create new Scrub notification
func createScrubNotification(date: Date) {
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Notification content
    let content = UNMutableNotificationContent()
    
    let hour: Int = Calendar.current.component(.hour, from: date)
    let minute: Int = Calendar.current.component(.minute, from: date)
    
    content.title = "Scrub"
    content.body = "It's \(hour):\(minute). Time to Scrub!"
    content.badge = 1
    content.categoryIdentifier = "ACTIONS"
    
    // Notification trigger
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    print(Calendar.current.component(.hour, from: date))
    print(Calendar.current.component(.minute, from: date))
    dateComponents.hour = Calendar.current.component(.hour, from: date)
    dateComponents.minute = Calendar.current.component(.minute, from: date)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    // Notification actions
    let start = UNNotificationAction(identifier: "START", title: "Start Timer")
    let liveActivity = UNNotificationAction(identifier: "START-IN-LIVE-ACTIVITY", title: "Start Timer in Live Activity", options: .foreground)
    let close = UNNotificationAction(identifier: "CLOSE", title: "Close", options: .destructive)
    
    let category = UNNotificationCategory(identifier: "ACTIONS", actions: [start, liveActivity, close], intentIdentifiers: [], options: [])
    notificationCenter.setNotificationCategories([category])
    
    // Make the notification
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString,
                content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
        print(error as Any)
    }
}


// Create new Brush notification
func createBrushNotification(startDate: Date) {
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Notification content
    let content = UNMutableNotificationContent()
    
    content.title = "It's been 4 months"
    content.body = "Time for a new brush!"
    content.badge = 1
    content.categoryIdentifier = "ACTIONS"
    
    // Notification trigger
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    print(Calendar.current.component(.hour, from: startDate))
    print(Calendar.current.component(.minute, from: startDate))
    dateComponents.hour = Calendar.current.component(.hour, from: startDate)
    dateComponents.minute = Calendar.current.component(.minute, from: startDate)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    // Notification actions
    let done = UNNotificationAction(identifier: "MARK-AS-DONE", title: "Mark as done")
    let notifyTomorrow = UNNotificationAction(identifier: "NOTIFY-TOMORROW", title: "Notify tomorrow", options: .foreground)
    let close = UNNotificationAction(identifier: "CLOSE", title: "Close", options: .destructive)
    
    let category = UNNotificationCategory(identifier: "ACTIONS", actions: [done, notifyTomorrow, close], intentIdentifiers: [], options: [])
    notificationCenter.setNotificationCategories([category])
    
    // Make the notification
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString,
                content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
        print(error as Any)
    }
}
