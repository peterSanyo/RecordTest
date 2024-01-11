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
                Gauge(value: Float(recCount)) {
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
