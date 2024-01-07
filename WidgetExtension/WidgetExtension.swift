//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Péter Sanyó on 05.01.24.
//

import Intents
import SwiftUI
import WidgetKit

// MARK: - Model

// This is the model for your widget's content. It conforms to TimelineEntry, which means it represents a single entry in the widget's timeline.
// It includes a date, indicating when this entry is relevant, and a list of recordings, which are the URLs to the audio recordings you want to display.
// WidgetKit uses this struct to understand what data to display at what time.
struct RecordingEntry: TimelineEntry {
    let date: Date
    let recordings: [URL]
}

// MARK: - Factory

// This is the 'factory' that creates the timeline entries for your widget. As a TimelineProvider, it's responsible for telling WidgetKit what to display and when.
// The placeholder method provides a preview of the widget in the Widget gallery before the widget is added to the watch face.
// The getSnapshot method provides a quick look at the widget's current state, used for previews while editing the watch face.
// The getTimeline method provides a sequence of entries that WidgetKit will transition through over time. This is where you'd fetch the latest recording data and schedule updates.
struct RecorderWidgetProvider: TimelineProvider {
    typealias Entry = RecordingEntry
    let appGroupUserDefaults: UserDefaults? = UserDefaults(suiteName: "group.PeterSanyo.RecordTest")

    func placeholder(in context: Context) -> RecordingEntry {
        RecordingEntry(date: Date(), recordings: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (RecordingEntry) -> ()) {
        // Use the shared UserDefaults
        if let recordingURLs = appGroupUserDefaults?.object(forKey: "recordingsURLs") as? [String] {
            let urls = recordingURLs.compactMap { URL(string: $0) }
            print("Retrieved URLs in Widget Snapshot: \(urls)")
            let entry = RecordingEntry(date: Date(), recordings: urls)
            completion(entry)
        } else {
            print("No URLs found in Widget Snapshot")
            let entry = RecordingEntry(date: Date(), recordings: [])
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RecordingEntry>) -> ()) {
        // Use the shared UserDefaults
        if let recordingURLs = appGroupUserDefaults?.object(forKey: "recordingsURLs") as? [String] {
            let urls = recordingURLs.compactMap { URL(string: $0) }
            // Define a refresh date
            let refreshDate = Date().addingTimeInterval(60 * 60) // for example, 60 seconds later
            print("Retrieved URLs in Widget Timeline: \(urls)")
            let entries = [RecordingEntry(date: Date(), recordings: urls)]
            let timeline = Timeline(entries: entries, policy: .after(refreshDate))

            

            // Use .after(date:) policy to update more frequently
            completion(timeline)
            completion(timeline)
        } else {
            print("No URLs found in Widget Timeline")
            let entries = [RecordingEntry(date: Date(), recordings: [])]
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

// MARK: - WidgetEntryView

// This is the SwiftUI view that defines the UI of your widget. It uses the data from RecordingEntry to build the interface that users will see.
// It uses the @Environment property wrapper to adapt its layout based on the complication family being used (such as .accessoryCircular, .accessoryCorner, etc.).
// Inside this view, you would typically switch on the widgetFamily to provide different layouts for different complication sizes and shapes.

struct RecorderWidgetEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var recordings: [URL]
    var entry: RecorderWidgetProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .accessoryInline:
            // layout for inline complication
            InlineComplicationView(recordings: entry.recordings)
        case .accessoryCircular:
            // layout for circular complication
            CircularComplicationView(recordings: entry.recordings); CircularRecordComplication()
        default:
            // default layout
            DefaultComplicationView(recordings: entry.recordings)
        }
    }
}

// MARK: - Main Entry Point

// This is the main entry point of your widget extension. It defines the overall configuration of your widget.
// It uses StaticConfiguration to set up a non-configurable widget that doesn't rely on user-selected options.
// It sets the kind, which is a unique identifier for the widget, used by the system to differentiate it from other widgets.
// The configurationDisplayName and description provide the name and description that appear in the widget gallery.
// The supportedFamilies array tells WidgetKit which complication families your widget supports.

@main
struct RecorderWidget: Widget {
    let kind: String = "RecorderWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: RecorderWidgetProvider())
        { entry in
            RecorderWidgetEntryView(recordings: entry.recordings, entry: entry)
        }
        .configurationDisplayName("Recordings Count")
        .description("Shows amount of recorded files.")
        .supportedFamilies([.accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular])
    }
}

// #Preview(as: .accessoryRectangular) {
//    WidgetExtension()
// } timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
// }
