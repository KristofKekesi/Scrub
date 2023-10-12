//
//  About.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 11..
//

import SwiftUI

struct About: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Text("About")
                    Spacer()
                }.font(.title.width(.expanded)).bold()
            }.padding([.bottom])
            Group {
                Label("Support", systemImage: "envelope").bold().font(.headline)
                Label("Website", systemImage: "link").bold().font(.headline)
                Label("Privacy policy", systemImage: "lock").bold().font(.headline)
                Divider()
            }.padding([.bottom])
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
