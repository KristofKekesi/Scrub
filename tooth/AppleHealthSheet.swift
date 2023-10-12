//
//  AppleHealthSheet.swift
//  tooth
//
//  Created by Kristóf Kékesi on 2023. 01. 04..
//

import SwiftUI

struct AppleHealthSheet: View {
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack {
                    Image("AppleHealthLogo").resizable()
                        .frame(width: 75, height: 75).shadow(radius: 50.0)
                    Text("Health Kit Integration").font(.body.width(.expanded)).bold()
                }
                Spacer()
            }.padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))
            Rectangle().fill(.black.opacity(0.25)).frame(minWidth: 1, idealWidth: .infinity, maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
            VStack(alignment: .leading) {
                Text("Why Apple Health?").font(.title3.width(.expanded)).bold()
                Text("With Apple Health connected you can easily check your toothbrushing history with the additional benefits of using Apple Health.").fixedSize(horizontal: false, vertical: true).foregroundStyle(.white.opacity(0.8)).bold()
            }.padding()
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("What will Scrub do?").font(.title3.width(.expanded)).bold()
                    Text("Scrub both writes and reads your toothbrusing data. Writes in order to save your health data. And reads to show the last time you brushed your teeth.").fixedSize(horizontal: false, vertical: true).foregroundStyle(.white.opacity(0.8)).bold()
                }.padding()
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Will it work without it?").font(.title3.width(.expanded)).bold()
                    Text("Scrub works with and without access granted to your teeth brushing data. For the best user experience I recommend connecting Scrub to Apple Health.").fixedSize(horizontal: false, vertical: true).foregroundStyle(.white.opacity(0.8)).bold()
                }.padding()
            }
            HStack {
                Spacer()
                Button {
                    healthStore?.requestAuthorization {
                        success in
                        print(success)
                    }
                } label: {
                    Label("Connect with Apple Health", systemImage: "heart.text.square.fill")
                }.buttonStyle(.borderedProminent).foregroundColor(.pink).tint(.white).padding()
                Spacer()
            }
        }.background(.pink).foregroundColor(.white).cornerRadius(16).padding()
    }
}

struct AppleHealthSheet_Previews: PreviewProvider {
    static var previews: some View {
        AppleHealthSheet().preferredColorScheme(.dark)
    }
}
