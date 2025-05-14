//
//  EmergencyWidgets.swift
//  Motive
//
//  Created by Michael Bautista on 5/13/25.
//

import WidgetKit
import SwiftUI

// MARK: Emergency structs
struct EmergencyEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

// MARK: Emergency provider
struct EmergencyProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> EmergencyEntry {
        EmergencyEntry(
            date: Date(),
            configuration: ConfigurationAppIntent()
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> EmergencyEntry {
        EmergencyEntry(
            date: Date(),
            configuration: ConfigurationAppIntent()
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<EmergencyEntry> {
        let entry = EmergencyEntry(
            date: .now,
            configuration: configuration
        )

        return Timeline(entries: [entry], policy: .never)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct EmergencyWidgets: Widget {
    let kind: String = "EmergencyWidgets"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: EmergencyProvider()) { entry in
            EmergencyWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Motive Widget")
        .description("Emergency motivation.")
        .supportedFamilies([
            .systemSmall,
            .accessoryRectangular
        ])
    }
}

// MARK: Emergency views
struct EmergencyWidgetsEntryView : View {
    var entry: EmergencyProvider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            VStack(spacing: 5) {
                Image(systemName: "exclamationmark.octagon.fill")
                    .foregroundStyle(Color.red)
                
                Text("TAP IF YOU HAVE A SLACK JAWED POOPY PANTS MENTALITY")
                    .font(Font.system(size: 14))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.red)
                    .multilineTextAlignment(.center)
            }
            .containerBackground(for: .widget) {
                Color.black
            }
            .widgetURL(URL(string: "motive://emergency"))
        case .accessoryRectangular:
            HStack(spacing: 5) {
                Image(systemName: "exclamationmark.octagon.fill")
                
                Text("I HAVE A SLACK JAWED POOPY PANTS MENTALITY")
                    .font(.custom("InterDisplay-Bold", size: 10))
                    .multilineTextAlignment(.leading)
            }
            .containerBackground(for: .widget) {
                Color.black
            }
            .widgetURL(URL(string: "motive://emergency"))
        default:
            Text("Error")
        }
    }
}

#Preview(as: .accessoryRectangular) {
    EmergencyWidgets()
} timeline: {
    EmergencyEntry(date: .now, configuration: .init())
}
