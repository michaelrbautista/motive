//
//  MotiveWidgets.swift
//  MotiveWidgets
//
//  Created by Michael Bautista on 4/29/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            quote: "The circumstances don't make the man. They merely reveal him to himself.",
            configuration: ConfigurationAppIntent()
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            quote: "The circumstances don't make the man. They merely reveal him to himself.",
            configuration: configuration
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(
                date: entryDate,
                quote: "Circumstances don't make the man. They merely reveal him to himself.",
                configuration: configuration
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: String
    let configuration: ConfigurationAppIntent
}

// MARK: Types
struct MotiveWidgets: Widget {
    let kind: String = "MotiveWidgets"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MotiveWidgetsEntryView(entry: entry)
                .containerBackground(Color.black, for: .widget)
        }
        .configurationDisplayName("Motive Widget")
        .description("Shows quotes.")
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryRectangular
        ])
    }
}

// MARK: Views
struct MotiveWidgetsEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            Text(entry.quote)
                .italic()
                .font(Font.subheadline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
        case .systemMedium:
            Text(entry.quote)
                .italic()
                .font(Font.headline)
                .fontWeight(.black)
                .foregroundStyle(Color.white)
        case .accessoryRectangular:
            Text(entry.quote)
        default:
            Text("Unsupported widget.")
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    MotiveWidgets()
} timeline: {
    SimpleEntry(date: .now, quote: "The circumstances don't make the man. They merely reveal him to himself.", configuration: .smiley)
}
