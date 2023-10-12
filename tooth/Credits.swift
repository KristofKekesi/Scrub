//
//  About.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 11..
//

import SwiftUI

struct Credit: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Text("Credits")
                    Spacer()
                }.font(.title.width(.expanded)).bold()
            }.padding([.bottom])
            Group {
                HStack {
                    Text("Kristóf Kékesi").bold().font(.headline)
                    Spacer()
                    Text("Everything")
                }
                HStack {
                    Text("Lucas Zischka").bold().font(.headline)
                    Spacer()
                    Text("BottomSheet Package")
                }
                HStack {
                    Text("Stream").bold().font(.headline)
                    Spacer()
                    Text("EffectLibrary Package")
                }
                Divider()
            }.padding([.bottom])
        }
    }
}

struct Credit_Previews: PreviewProvider {
    static var previews: some View {
        Credit()
    }
}
