//
//  AudioCommentViewController.swift
//  LambdaTimeline
//
//  Created by Vici Shaweddy on 1/17/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation
import Accelerate

enum RecorderState {
    case recording
    case stopped
    case denied
}

protocol RecorderViewControllerDelegate: class {
    func didStartRecording()
    func didFinishRecording()
}

let keyID = "key"

class AudioCommentViewController: UIViewController {
    
    // MARK: - Properties
    var handleView = UIView()
    var recordButton = RecordButton()
    var timeLabel = UILabel()
    var audioView = AudioVisualizerView()
    let settings = [AVFormatIDKey: kAudioFormatLinearPCM, AVLinearPCMBitDepthKey: 16, AVLinearPCMIsFloatKey: true, AVSampleRateKey: Float64(44100), AVNumberOfChannelsKey: 1] as [String : Any]
    let audioEngine = AVAudioEngine()
    private var renderTs: Double = 0
    private var recordingTs: Double = 0
    private var silenceTs: Double = 0
    private var audioFile: AVAudioFile?
    weak var delegate: AudioCommentViewControllerDelegate?
    
    fileprivate func setupRecordingButton() {
        recordButton.isRecording = false
        recordButton.addTarget(self, action: #selector(handleRecording(_:)), for: .touchUpInside)
        view.addSubview(recordButton)
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    // MARK: - Actions
    @objc func handleRecording(_ sender: RecordButton) {
        var defaultFrame: CGRect = CGRect(x: 0, y: 24, width: view.frame.width, height: 135)
        if recordButton.isRecording {
            defaultFrame = self.view.frame
            audioView.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.handleView.alpha = 1
                self.timeLabel.alpha = 1
                self.audioView.alpha = 1
                self.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: -300)
                self.view.layoutIfNeeded()
            }, completion: nil)
            self.checkPermissionAndRecord()
        } else {
            audioView.isHidden = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.handleView.alpha = 0
                self.timeLabel.alpha = 0
                self.audioView.alpha = 0
                self.view.frame = defaultFrame
                self.view.layoutIfNeeded()
            }, completion: nil)
            self.stopRecording()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
