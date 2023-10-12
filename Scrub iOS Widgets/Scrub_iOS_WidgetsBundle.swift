//
//  Scrub_iOS_WidgetsBundle.swift
//  Scrub iOS Widgets
//
//  Created by Kristóf Kékesi on 2023. 04. 19..
//

import WidgetKit
import SwiftUI

@main
struct Scrub_iOS_WidgetsBundle: WidgetBundle {
    var body: some Widget {
        Scrub_iOS_Widgets()
        Scrub_iOS_WidgetsLiveActivity()
    }
}
