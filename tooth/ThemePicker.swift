//
//  ThemePicker.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 17..
//

import SwiftUI
import WidgetKit

struct ThemePicker: View {
    @Binding var currentTheme: String
    @State var theme: String
    
    var body: some View {
        ZStack {
            Circle().fill(Color("ColorPalette_\(theme)_tint"))
            if currentTheme == theme {
                Circle().fill(.white.opacity(1)).padding(10)
            }
        }.onTapGesture {
            if currentTheme != theme {
                withAnimation {
                    currentTheme = theme
                }
                WidgetCenter.shared.reloadAllTimelines()
                print("done")
            }
        }.frame(width: 50, height: 50)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(currentTheme: .constant("yellow"), theme: "yellow")
    }
}
