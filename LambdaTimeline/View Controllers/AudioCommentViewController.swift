//
//  AudioCommentViewController.swift
//  LambdaTimeline
//
//  Created by Vici Shaweddy on 1/17/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AudioCommentViewController: UIViewController {
    
    // MARK: - Properties
    let recordController = RecordController()
    let postController = PostController()
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    @IBAction func recordPressed(_ sender: Any) {
        if recordController.isRecording {
            self.recordController.stopRecording()
        } else {
            self.recordController.startRecording()
        }
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let url = self.recordController.audioURL,
            let post = self.post else { return }
        
        self.postController.addComment(with: .audio(url), to: post)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
