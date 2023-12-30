//
//  HomeView.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import AVFoundation
import SwiftUI
import WatchKit

struct HomeView: View {
    @StateObject var audioRecorder = AudioRecorder()

    var body: some View {
        ScrollView {
            VStack {
                //            if audioRecorder.hasRecordingPermission {
                ActionButton()
                //            } else {
                //                Text("Recording permissions not granted. Please enable them in settings.")
                //            }

                Divider()

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
        .navigationTitle("Record")
        .onAppear {
            audioRecorder.setupAudioSession()
        }
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
    HomeView()
}
