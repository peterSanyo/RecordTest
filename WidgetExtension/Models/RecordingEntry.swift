//
//  RecordingEntry.swift
//  RecordTest
//
//  Created by Péter Sanyó on 07.01.24.
//

import WidgetKit

struct RecordingEntry: TimelineEntry {
    let date: Date
    let recordings: [URL]
}

