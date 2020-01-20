//
//  Comment.swift
//  LambdaTimeline
//
//  Created by Spencer Curtis on 10/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import FirebaseAuth

enum Media {
    case text(String)
    case audio(URL)
}

class Comment: FirebaseConvertible, Equatable {
    static private let textKey = "text"
    static private let audioKey = "audio"
    static private let authorKey = "author"
    static private let timestampKey = "timestamp"
    
    let text: String?
    let audio: URL?
    let author: Author
    let timestamp: Date
    
    init(media: Media, author: Author, timestamp: Date = Date()) {
        if case .text(let text) = media {
            self.text = text
            self.audio = nil
        } else if case .audio(let audio) = media {
            self.audio = audio
            self.text = nil
        } else {
            self.text = nil
            self.audio = nil
        }
        
        self.author = author
        self.timestamp = timestamp
    }
    
    init?(dictionary: [String: Any]) {
        guard let authorDictionary = dictionary[Comment.authorKey] as? [String: Any],
            let author = Author(dictionary: authorDictionary),
            let timestampTimeInterval = dictionary[Comment.timestampKey] as? TimeInterval else { return nil }
        
        self.text = dictionary[Comment.textKey] as? String
        self.audio = dictionary[Comment.audioKey] as? URL
        self.author = author
        self.timestamp = Date(timeIntervalSince1970: timestampTimeInterval)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [Comment.textKey: text ?? "",
                Comment.audioKey: audio ?? "",
                Comment.authorKey: author.dictionaryRepresentation,
                Comment.timestampKey: timestamp.timeIntervalSince1970]
    }
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.author == rhs.author &&
            lhs.timestamp == rhs.timestamp
    }
}
