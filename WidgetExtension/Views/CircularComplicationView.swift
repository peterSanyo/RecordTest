//
//  CircularComplicationView.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 05.01.24.
//

import SwiftUI
import WidgetKit

struct CircularComplicationView: View {
    var recordings: [URL]

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(style: StrokeStyle(lineWidth: 3))
            Text("\(recordings.count)")
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
}

struct CircularComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecordings = (1 ... 12).map { _ in URL(fileURLWithPath: "path/to/recording.m4a") }

        CircularComplicationView(recordings: mockRecordings)
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Accessory Circular")
    }
}
