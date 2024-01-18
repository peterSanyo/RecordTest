//
//  InlineComplicationView.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 05.01.24.
//

import SwiftUI
import WidgetKit

struct InlineComplicationView: View {
    var recordings: [URL]
    var body: some View {
        HStack {
            Image(systemName: "mic")

            Text("Recordings: \(recordings.count)")
            .widgetAccentable()
        }
    }
}

struct InlineComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecordings = (1 ... 12).map { _ in URL(fileURLWithPath: "path/to/recording.m4a") }

        InlineComplicationView(recordings: mockRecordings)
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
            .previewDisplayName("Accessory Inline")
    }
}
