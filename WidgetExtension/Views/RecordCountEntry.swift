//
//  RecordCountEntry.swift
//  RecordTest
//
//  Created by Péter Sanyó on 08.01.24.
//

import SwiftUI
import WidgetKit

// This is the SwiftUI view that defines the UI of your widget. It uses the data from RecordingEntry to build the interface that users will see.
// It uses the @Environment property wrapper to adapt its layout based on the complication family being used (such as .accessoryCircular, .accessoryCorner, etc.).
// Inside this view, you would typically switch on the widgetFamily to provide different layouts for different complication sizes and shapes.

struct RecordCountEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    var recordings: [URL]
    var entry: RecordCountProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .accessoryInline:
            // layout for inline complication
            InlineComplicationView(recordings: entry.recordings)
        case .accessoryCircular:
            // layout for circular complication
            CircularComplicationView(recordings: entry.recordings)
        case .accessoryCorner:
            CornerComplicationView(recordings: entry.recordings)
        default:
            // default layout
            DefaultComplicationView(recordings: entry.recordings)
        }
    }
}

struct RecordCountEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecordings = (1 ... 12).map { _ in URL(fileURLWithPath: "path/to/recording.m4a") }
        
        // Create a mock entry
        let entry = RecordCountProvider.Entry(date: Date(), recordings: mockRecordings)

        RecordCountEntryView(recordings: mockRecordings, entry: entry)
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Accessory Circular")
    }
}
