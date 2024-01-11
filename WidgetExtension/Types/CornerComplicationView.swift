//
//  CornerComplicationView.swift
//  RecordTest
//
//  Created by Péter Sanyó on 11.01.24.
//

import SwiftUI
import WidgetKit

struct CornerComplicationView: View {
    var recordings: [URL]

    var body: some View {
        ZStack {
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
        .widgetLabel {
            Text("Recordings: \(recordings.count)")
        }
    }
}

struct CornerComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecordings = (1 ... 12).map { _ in URL(fileURLWithPath: "path/to/recording.m4a") }

        CornerComplicationView(recordings: mockRecordings)
            .previewContext(WidgetPreviewContext(family: .accessoryCorner))
            .previewDisplayName("Accessory Corner")
    }
}
