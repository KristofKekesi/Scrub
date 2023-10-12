//
//  Scrub_iOS_WidgetsLiveActivity.swift
//  Scrub iOS Widgets
//
//  Created by Kristóf Kékesi on 2023. 04. 19..
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Scrub_iOS_WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: Int
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct Scrub_iOS_WidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Scrub_iOS_WidgetsAttributes.self) { context in
            HStack {
                ZStack {
                    Circle()
                        .stroke( // 1
                            Color("ColorPalette_indigo_tint"),
                            lineWidth: 8
                        ).frame(width: 215 / 2, height: 215 / 2)
                    Button {
                    } label: {Text("🪥").font(.system(size: 60)).frame(width: 100, height: 100).background(Color("ColorPalette_indigo_brush")).cornerRadius(.infinity)
                    }
                }.frame(minWidth: 1, idealWidth: 175, maxWidth: 175, minHeight: 175, idealHeight: 175, maxHeight: 175, alignment: .center)
                Spacer()
                Text("1:48")
            }
            .padding()
            .activityBackgroundTint(Color("ColorPalette_indigo_foreground"))
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Scrub").font(.title3.width(.expanded).bold())
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Button {} label: {
                        Label("Stop", systemImage: "xmark").font(.headline.width(.expanded))
                    }.tint(Color("ColorPalette_indigo_tint"))
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(spacing: 0) {
                        Spacer()
                        HStack(alignment: .firstTextBaseline) {
                            Text("1:23").font(.largeTitle.width(.expanded)).bold()
                        }
                        HStack {
                            Text("0:00").font(.caption).bold().foregroundColor(.gray)
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color("ColorPalette_indigo_tint"))
                                    .cornerRadius(.infinity)
                                Rectangle().fill(Color("ColorPalette_indigo_brush"))
                                    .cornerRadius(.infinity)
                                    .frame(width: 200)
                            }.frame(height: 5)
                            Text("2:00").font(.caption).bold().foregroundColor(.gray)
                        }
                    }.padding()
                }
            } compactLeading: {
                Text("🪥").padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
            } compactTrailing: {
                Text("1:31")
            } minimal: {
                Text("1:31")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

struct Scrub_iOS_WidgetsLiveActivity_Previews: PreviewProvider {
    static let attributes = Scrub_iOS_WidgetsAttributes(name: "Me")
    static let contentState = Scrub_iOS_WidgetsAttributes.ContentState(value: 3)

    static var previews: some View {
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.compact))
            .previewDisplayName("Island Compact")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
            .previewDisplayName("Island Expanded")
        attributes
            .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
            .previewDisplayName("Minimal")
        attributes
            .previewContext(contentState, viewKind: .content)
            .previewDisplayName("Notification")
    }
}
