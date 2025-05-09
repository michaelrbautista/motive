//
//  MotiveWidgets.swift
//  MotiveWidgets
//
//  Created by Michael Bautista on 4/29/25.
//

import WidgetKit
import SwiftUI

// MARK: Quote type
struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: String
    let source: String
    let configuration: ConfigurationAppIntent
}

struct FetchedQuote {
    let quote: String
    let source: String
}

// MARK: Quote provider
struct QuoteProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: "...",
            source: "...",
            configuration: ConfigurationAppIntent()
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: "Quote",
            source: "Source",
            configuration: configuration
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<QuoteEntry> {
        let todaysQuote = loadQuote()
        
        let entry = QuoteEntry(
            date: .now,
            quote: todaysQuote.quote,
            source: todaysQuote.source,
            configuration: configuration
        )

        return Timeline(entries: [entry], policy: .never)
    }
    
    // MARK: Load quote
    private func loadQuote() -> FetchedQuote {
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        
        #if DEBUG
        // For screenshots
//        let quote = FetchedQuote(
//            quote: "No one is going to come help you. No one's coming to save you.",
//            source: "David Goggins",
//        )
        let quote = FetchedQuote(
            quote: userDefaults?.value(forKey: "quote") as? String ?? "No current quote.",
            source: userDefaults?.value(forKey: "source") as? String ?? "No current source."
        )
        #else
        let quote = FetchedQuote(
            quote: userDefaults?.value(forKey: "quote") as? String ?? "Circumstances don't make the man, they only reveal him to himself.",
            source: userDefaults?.value(forKey: "source") as? String ?? "Epictetus"
        )
        #endif
        
        return quote
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct QuoteWidgets: Widget {
    let kind: String = "QuoteWidgets"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: QuoteProvider()) { entry in
            QuoteWidgetsEntryView(entry: entry)
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

// MARK: Quote views
struct QuoteWidgetsEntryView : View {
    var entry: QuoteProvider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            VStack(alignment: .leading, spacing: 5) {
                Text(entry.quote)
                    .font(.custom("InterDisplay-Bold", size: 14))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(5)
                Text(entry.source)
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
            }
            .containerBackground(for: .widget) {
                Color.black
            }
        case .systemMedium:
            VStack(alignment: .leading, spacing: 5) {
                Text(entry.quote)
                    .font(.custom("InterDisplay-Bold", size: 16))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(5)
                Text(entry.source)
                    .font(.custom("InterDisplay-Bold", size: 14))
                    .foregroundStyle(Color.gray)
                    .lineLimit(1)
            }
            .containerBackground(for: .widget) {
                Color.black
            }
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 0) {
                Text(entry.source)
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                Text(entry.quote)
                    .font(.custom("InterDisplay", size: 10))
                    .foregroundStyle(Color.white)
            }
        default:
            Text("Unsupported widget.")
        }
    }
}

#Preview(as: .systemMedium) {
    QuoteWidgets()
} timeline: {
    QuoteEntry(date: .now, quote: "The secret of getting ahead is getting started.", source: "Mark Twain", configuration: .init())
}
