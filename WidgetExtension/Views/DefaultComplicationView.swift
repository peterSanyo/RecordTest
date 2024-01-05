//
//  DefaultComplicationView.swift
//  RecordTest
//
//  Created by Péter Sanyó on 05.01.24.
//

import SwiftUI
import WidgetKit

struct DefaultComplicationView: View {
    var recordings: [URL]

    var body: some View {
            Text("Recordings: \(recordings.count)")
    }
}

struct DefaultComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRecordings = (1 ... 12).map { _ in URL(fileURLWithPath: "path/to/recording.m4a") }

        DefaultComplicationView(recordings: mockRecordings)
            .previewContext(WidgetPreviewContext(family: .accessoryInline))
            .previewDisplayName("Accessory Inline")
    }
}
