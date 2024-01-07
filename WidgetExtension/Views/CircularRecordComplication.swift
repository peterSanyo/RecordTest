//
//  CircularRecordComplication.swift
//  RecordTest
//
//  Created by Péter Sanyó on 07.01.24.
//

import SwiftUI
import WidgetKit

struct CircularRecordComplication: View {
    @State private var isRecording = false
    let appGroupUserDefaults: UserDefaults? = UserDefaults(suiteName: "group.peterSanyo.Recordtest")
    var body: some View {
        ZStack {
            Circle()
                .mask(gradient)
                .overlay(Circle().stroke(lineWidth: 2))
                .widgetAccentable()
            
            Image(systemName: isRecording ? "circle.fill" : "mic")
                .foregroundColor( isRecording ? .red : .accentColor)
                .onAppear {
                    isRecording = appGroupUserDefaults?.bool(forKey: "isRecording") ?? false
                }
        }
        .widgetAccentable()
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
    let gradient = LinearGradient(
        gradient: Gradient(
            stops: [
            .init(color: .clear, location: 0),
            .init(color: .white.opacity(0.3), location: 0.7),
            .init(color: .black, location: 1)]
        ),
        startPoint: .bottomTrailing,
        endPoint: .topLeading
    )
}

struct CircularRecordComplication_Previews: PreviewProvider {
    static var previews: some View {
        CircularRecordComplication()
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Accessory Circular")
            
    }
}
