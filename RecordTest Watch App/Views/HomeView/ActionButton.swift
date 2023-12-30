//
//  ActionButton.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import SwiftUI

struct ActionButton: View {
    @StateObject var audioRecorder = AudioRecorder()

    var body: some View {
        Button {
            if audioRecorder.isRecording {
                audioRecorder.stopRecording()
            } else {
                audioRecorder.startRecording()
            }
        } label: {
            ZStack {
                Circle()
                    .strokeBorder(style: StrokeStyle(lineWidth: audioRecorder.isRecording ? 0 : 1))
                
                actionShape
                    .padding()
                        
                Text(audioRecorder.isRecording ? "Stop (\(Int(audioRecorder.recordingTime)))" : "Record")
                    .bold()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - UI
    
    var actionShape: some View {
        Group {
            if audioRecorder.isRecording {
                Rectangle().fill(Color.red)
            } else {
                Circle().fill(Color.red)
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

#Preview {
    ActionButton()
}
