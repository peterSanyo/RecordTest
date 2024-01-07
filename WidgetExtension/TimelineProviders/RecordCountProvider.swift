//
//  RecordCountProvider.swift
//  RecordTest
//
//  Created by Péter Sanyó on 07.01.24.
//

import WidgetKit

// This is the 'factory' that creates the timeline entries for your widget. As a TimelineProvider, it's responsible for telling WidgetKit what to display and when.
// The placeholder method provides a preview of the widget in the Widget gallery before the widget is added to the watch face.
// The getSnapshot method provides a quick look at the widget's current state, used for previews while editing the watch face.
// The getTimeline method provides a sequence of entries that WidgetKit will transition through over time. This is where you'd fetch the latest recording data and schedule updates.
struct RecordCountProvider: TimelineProvider {
    typealias Entry = RecordingEntry
    let appGroupUserDefaults: UserDefaults? = UserDefaults(suiteName: "group.PeterSanyo.RecordTest")

    func placeholder(in context: Context) -> RecordingEntry {
        RecordingEntry(
            date: Date(),
            recordings: []
        )
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
