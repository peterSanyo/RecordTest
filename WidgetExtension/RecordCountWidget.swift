//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Péter Sanyó on 05.01.24.
//

import SwiftUI
import WidgetKit

// MARK: - Main Entry Point

// This is the main entry point of your widget extension. It defines the overall configuration of your widget.
// It uses StaticConfiguration to set up a non-configurable widget that doesn't rely on user-selected options.
// It sets the kind, which is a unique identifier for the widget, used by the system to differentiate it from other widgets.
// The configurationDisplayName and description provide the name and description that appear in the widget gallery.
// The supportedFamilies array tells WidgetKit which complication families your widget supports.

@main
struct RecordCountWidget: Widget {
    let kind: String = "RecordCountWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: RecordCountProvider())
        { entry in
            RecordCountEntryView(recordings: entry.recordings, entry: entry)
        }
        .configurationDisplayName("Recordings Count")
        .description("Shows amount of recorded files.")
        .supportedFamilies([.accessoryCircular, .accessoryCorner, .accessoryInline, .accessoryRectangular])
    }
}
