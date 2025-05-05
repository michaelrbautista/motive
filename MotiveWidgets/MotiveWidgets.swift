//
//  MotiveWidgets.swift
//  MotiveWidgets
//
//  Created by Michael Bautista on 4/29/25.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: "Circumstances don't make the man, they only reveal him to himself.",
            source: "Epictetus",
            image: Data(),
            configuration: ConfigurationAppIntent()
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> QuoteEntry {
        QuoteEntry(
            date: Date(),
            quote: "Circumstances don't make the man, they only reveal him to himself.",
            source: "Epictetus",
            image: Data(),
            configuration: configuration
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<QuoteEntry> {
        let todaysQuote = loadQuote()
        
        let entry = QuoteEntry(
            date: .now,
            quote: todaysQuote.quote,
            source: todaysQuote.source,
            image: todaysQuote.image,
            configuration: configuration
        )

        return Timeline(entries: [entry], policy: .never)
    }
    
    // MARK: Load quote
    private func loadQuote() -> FetchedQuote {
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        
        let quote = FetchedQuote(
            quote: userDefaults?.value(forKey: "quote") as? String ?? "Circumstances don't make the man, they only reveal him to himself.",
            source: userDefaults?.value(forKey: "source") as? String ?? "Epictetus",
            image: userDefaults?.value(forKey: "image") as? Data ?? Data()
        )
        
        return quote
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

// MARK: Model
struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: String
    let source: String
    let image: Data
    let configuration: ConfigurationAppIntent
}

struct FetchedQuote {
    let quote: String
    let source: String
    let image: Data
}

// MARK: Types
struct MotiveWidgets: Widget {
    let kind: String = "MotiveWidgets"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            MotiveWidgetsEntryView(entry: entry)
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
                if let image = UIImage(data: entry.image) {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        
                        Color.black
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .opacity(0.8)
                    }
                } else {
                    Color.black
                }
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
                if let image = UIImage(data: entry.image) {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        
                        Color.black
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .opacity(0.8)
                    }
                } else {
                    Color.black
                }
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
    MotiveWidgets()
} timeline: {
    QuoteEntry(date: .now, quote: "The secret of getting ahead is getting started.", source: "Mark Twain", image: Data(), configuration: .init())
}
