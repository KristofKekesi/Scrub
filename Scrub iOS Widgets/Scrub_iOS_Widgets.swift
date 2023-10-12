//
//  Scrub_iOS_Widgets.swift
//  Scrub iOS Widgets
//
//  Created by Kristóf Kékesi on 2023. 04. 19..
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Scrub_iOS_WidgetsEntryView : View {
    @Environment(\.widgetFamily) var WidgetFamily: WidgetFamily
    
    private func getCurrentTheme() -> String {
        let defaults = UserDefaults(suiteName: "group.dev.kekesi.tooth")
        return defaults?.string(forKey: "currentTheme") ?? "yellow"
    }
    
    var entry: Provider.Entry

    var body: some View {
        let currentTheme = getCurrentTheme()
        
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Next:")
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("7:30 ").font(.title.width(.expanded)).bold().privacySensitive()
                    if WidgetFamily == .systemSmall {
                        Spacer()
                    }
                    Text("AM").font(.headline.width(.expanded)).bold().privacySensitive()
                }
            }.padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))
            Group {
                Divider()
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text("After:")
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("8:00").font(.headline.width(.expanded)).bold()
                            Text("PM").font(.caption.width(.expanded)).bold()
                        }.privacySensitive()
                    }
                }.padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            }
            Spacer()
            HStack {
                Spacer()
                Text("Scrub").font(.title3.width(.expanded)).bold()
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
        }
        .background(Color("ColorPalette_\(currentTheme)_tint").gradient)
        .foregroundColor(Color("ColorPalette_\(currentTheme)_foreground"))
    }
}

struct Scrub_iOS_Widgets: Widget {
    let kind: String = "Scrub_iOS_Widgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Scrub_iOS_WidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Next Scrub")
        .description("See your next Scrub to don't miss out.")
    }
}

struct Scrub_iOS_Widgets_Previews: PreviewProvider {
    static var previews: some View {
        Scrub_iOS_WidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        Scrub_iOS_WidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        Scrub_iOS_WidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
