//
//  AudioRecorder.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 29.12.23.
//

import Foundation
import Foundation
import AVFoundation

class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    let audioSession = AVAudioSession.sharedInstance()
    
    @Published var isRecording = false
    
    override init() {
        super.init()
        setupAudioSession()
    }
    
    func setupAudioSession() {
        do {
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if !allowed {
                        // Inform the user that they need to enable permissions
                    }
                }
            }
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Could not start recording: \(error)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            isRecording = false
            // Handle recording failure
        }
    }
}
