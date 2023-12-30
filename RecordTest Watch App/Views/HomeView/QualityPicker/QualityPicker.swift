//
//  QualityPicker.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import AVFoundation
import SwiftUI

struct QualityPicker: View {
    @StateObject var audioRecorder = AudioRecorder()
    @State private var selection: String = "High"
    
    var body: some View {
        HStack {
            QualityButton(title: "L", fullTitle: "Low", selection: $selection,  isRecording: $audioRecorder.isRecording) {
                audioRecorder.selectedQuality = AVAudioQuality.low.rawValue
            }
            QualityButton(title: "M", fullTitle: "Medium", selection: $selection,  isRecording: $audioRecorder.isRecording) {
                audioRecorder.selectedQuality = AVAudioQuality.medium.rawValue
            }
            QualityButton(title: "H", fullTitle: "High", selection: $selection,  isRecording: $audioRecorder.isRecording) {
                audioRecorder.selectedQuality = AVAudioQuality.high.rawValue
            }
        }
//        .frame(width: .infinity)
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
        .padding(.horizontal, 5)
        .disabled(isRecording)
        .buttonStyle(PlainButtonStyle())
        .padding()
        .background(selection == fullTitle ? Color.red : Color.gray)
        .cornerRadius(88)
    }
}

#Preview {
    QualityPicker()
}
