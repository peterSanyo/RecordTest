//
//  QualityPicker.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import AVFoundation
import SwiftUI
import WatchKit

struct QualityPicker: View {
    @ObservedObject var audioRecorder: AudioRecorder
    @State private var selection: String = "High"

    private let qualities = [
        ("L", "Low", AVAudioQuality.low.rawValue),
        ("M", "Medium", AVAudioQuality.medium.rawValue),
        ("H", "High", AVAudioQuality.high.rawValue)
    ]

    var body: some View {
        HStack {
            ForEach(qualities, id: \.1) { quality in
                QualityButton(
                    title: quality.0,
                    fullTitle: quality.1,
                    selection: $selection,
                    isRecording: $audioRecorder.isRecording)
                {
                    audioRecorder.selectedQuality = quality.2
                }
            }
        }
    }
}

struct QualityButton: View {
    let title: String
    let fullTitle: String
    @Binding var selection: String
    @Binding var isRecording: Bool
    var action: () -> Void

    var body: some View {
        Button {
            withAnimation {
                self.selection = self.fullTitle
                self.action()
            }
        } label: {
            ZStack {
                Text(selection == fullTitle ? fullTitle : title)
            }
        }
        .disabled(isRecording)
        .padding(.horizontal, 5)
        .buttonStyle(PlainButtonStyle())
        .padding()
        .background(selection == fullTitle ? Color.red : Color.gray)
        .cornerRadius(80)
    }
}

//#Preview {
//    QualityPicker()
//}
