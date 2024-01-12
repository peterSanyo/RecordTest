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
    @Environment(\.showsWidgetLabel) var showsWidgetLabel
    let maxRecordingsCount = 100

    var body: some View {
        let recCount = recordings.count
        ZStack {
            if showsWidgetLabel {
                ZStack {
                    Circle()
                        .mask(CustomGradient.customGradient)
                        .overlay(Circle().stroke(lineWidth: 2))
                        .widgetAccentable()

                    Text("\(recCount)")
                        .bold()
                }
                .widgetLabel {
                    Text("Recordings: \(recCount) ")
                }
            } else {
                let normalizedValue = Float(recordings.count) / Float(maxRecordingsCount)
                let clampedValue = min(1.0, max(0.0, normalizedValue))

                Gauge(value: clampedValue) {
                    Image(systemName: "mic")
                        .resizable()
                        .scaledToFit()
                } currentValueLabel: {
                    Text("\(recordings.count)")
                }
                .gaugeStyle(.circular)
            }
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
