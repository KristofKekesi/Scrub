//
//  toothApp.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 04..
//

import SwiftUI

@main
struct toothApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().defaultAppStorage(UserDefaults(suiteName: "group.dev.kekesi.tooth")!)
        }
    }
}
