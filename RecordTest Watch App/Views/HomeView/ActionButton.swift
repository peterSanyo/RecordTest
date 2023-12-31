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
                RoundedRectangle(cornerRadius: audioRecorder.isRecording ? 5 : 500)
                    .stroke(lineWidth: 1)
                
                RoundedRectangle(cornerRadius: audioRecorder.isRecording ? 5 : 500)
                    .foregroundColor(.red)
                    .padding()
                
                Text(audioRecorder.isRecording ? "Stop (\(Int(audioRecorder.recordingTime)))" : "Record")
                    .bold()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 150, height: 75)
    }
    
    // MARK: - UI
    
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
//    @StateObject var audioRecorder = AudioRecorder()
//    
//    ActionButton(audioRecorder: audioRecorder)
//}
