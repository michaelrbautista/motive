//
//  ImageWidgets.swift
//  Motive
//
//  Created by Michael Bautista on 5/5/25.
//

import WidgetKit
import SwiftUI

// MARK: Image structs
struct ImageEntry: TimelineEntry {
    let date: Date
    let image: Data
    let configuration: ConfigurationAppIntent
}

struct FetchedImage {
    let image: Data
}

// MARK: Image provider
struct ImageProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ImageEntry {
        ImageEntry(
            date: Date(),
            image: Data(),
            configuration: ConfigurationAppIntent()
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ImageEntry {
        ImageEntry(
            date: Date(),
            image: Data(),
            configuration: ConfigurationAppIntent()
        )
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ImageEntry> {
        let image = loadImage()
        
        let entry = ImageEntry(
            date: .now,
            image: image.image,
            configuration: configuration
        )

        return Timeline(entries: [entry], policy: .never)
    }
    
    // MARK: Load image
    private func loadImage() -> FetchedImage {
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        
        #if DEBUG
        // For testing
//        let image = FetchedImage(imageName: "davidGoggins")
        let image = FetchedImage(
            image: userDefaults?.value(forKey: "image") as? Data ?? Data()
        )
        #else
        let image = FetchedImage(
            imageName: userDefaults?.value(forKey: "image") as? Data ?? Data()
        )
        #endif
        
        return image
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct ImageWidgets: Widget {
    let kind: String = "ImageWidgets"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: ImageProvider()) { entry in
            ImageWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Motive Widget")
        .description("Shows quotes.")
        .supportedFamilies([
            .systemMedium
        ])
    }
}

// MARK: Image views
struct ImageWidgetsEntryView : View {
    var entry: ImageProvider.Entry
    
    @Environment(\.widgetFamily) var family

    var body: some View {
        Color.clear
            .containerBackground(for: .widget) {
                if let image = UIImage(data: entry.image) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image("noImage")
                }
            }
    }
}

#Preview(as: .systemMedium) {
    ImageWidgets()
} timeline: {
    ImageEntry(date: .now, image: Data(), configuration: .init())
}
