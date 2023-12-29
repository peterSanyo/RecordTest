//
//  ContentView.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 29.12.23.
//
import AVFoundation
import SwiftUI
import WatchKit

struct ContentView: View {
    @StateObject var audioRecorder = AudioRecorder()

    var body: some View {
        VStack {
            if audioRecorder.hasRecordingPermission {
                Button {
                    if audioRecorder.isRecording {
                        audioRecorder.stopRecording()
                        audioRecorder.stopTimer()
                    } else {
                        audioRecorder.startRecording()
                        audioRecorder.startTimer()
                    }
                } label: {
                    ZStack {
                        Text(audioRecorder.isRecording ? "Stop (\(Int(audioRecorder.recordingTime)))" : "Record")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            } else {
                Text("Recording permissions not granted. Please enable them in settings.")
            }

            Divider()

            List {
                ForEach(audioRecorder.recordings, id: \.self) { recording in
                    Button {
                        audioRecorder.playRecording(url: recording)
                    } label: {
                        HStack {
                            Text(recording.lastPathComponent)
                            Spacer()
                            Image(systemName: "play.circle")
                        }
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .padding(4)
        .onAppear {
            audioRecorder.setupAudioSession()
        }
        .ignoresSafeArea()
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let recording = audioRecorder.recordings[index]
            try? FileManager.default.removeItem(at: recording)
        }
        audioRecorder.recordings.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
