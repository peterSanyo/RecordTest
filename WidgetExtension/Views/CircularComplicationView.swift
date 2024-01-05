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
            // Define the gradient
            let gradient = LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .clear, location: 0.5),
                    .init(color: .white.opacity(0.3), location: 0.7),
                    .init(color: .white, location: 1)
                ]),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )

            Circle()
                .strokeBorder(lineWidth: 1)

            Circle()
                .mask(gradient)

            Text("\(recordings.count)")
        }
        .widgetAccentable()
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
