//
//  ActionButton.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import AVFoundation
import SwiftUI
import WatchKit

struct ActionButton: View {
    @ObservedObject var audioRecorder: AudioRecorder

    var body: some View {
        Button {
            if audioRecorder.isRecording {
                audioRecorder.stopRecording()
            } else {
                audioRecorder.startRecording()
            }
        } label: {
            ZStack {
                Circle().strokeBorder(style: StrokeStyle(lineWidth: audioRecorder.isRecording ? 0 : 1))
                
                actionShape
                    .foregroundColor(.red)
                    .padding()
                
                Text(audioRecorder.isRecording ? "Stop (\(Int(audioRecorder.recordingTime)))" : "Record")
                    .bold()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: 100)
    }
    
    // MARK: - UI
    
    var actionShape: some View {
        Group {
            if audioRecorder.isRecording {
                Rectangle()
            } else {
                Circle()
            }
        }
    }
    
    // MARK: - Logic
    
    private func toggleRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stopRecording()
        } else {
            audioRecorder.startRecording()
        }
    }
}

//#Preview {
//    ActionButton()
//        .environmentObject(AudioRecorder())
//}
