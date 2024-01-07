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
    @State private var gradientAnimation = 0.9

    var body: some View {
        ZStack {
            let gradient = LinearGradient(
                gradient: Gradient(
                    stops: [
                    .init(color: .clear, location: 0),
                    .init(color: .white.opacity(0.3), location: gradientAnimation),
                    .init(color: .black, location: 1)]
                ),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            
            Circle()
                .mask(gradient)
                .overlay(Circle().stroke(lineWidth: 2))
                .widgetAccentable()

            Text("\(recordings.count)")
                .bold()
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
