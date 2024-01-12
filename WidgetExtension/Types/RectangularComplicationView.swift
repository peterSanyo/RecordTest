//
//  RectangularComplicationView.swift
//  RecordTest
//
//  Created by Péter Sanyó on 12.01.24.
//

import SwiftUI
import WidgetKit

struct RectangularComplicationView: View {
    var recordings: [URL]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "mic")
                Text("RecordTest")
            }
            .bold()
            .widgetAccentable()

            Gauge(value: Float(recordings.count),
                  in: 0 ... 100,
                  label: {
                Text("Recordings: \(recordings.count)")
                  }
            ).gaugeStyle(.linearCapacity)
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct RectangularComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecordings = (1 ... 12).map { _ in URL(fileURLWithPath: "path/to/recording.m4a") }

        RectangularComplicationView(recordings: mockRecordings)
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
