//
//  RPComment.swift
//  RPComment
//
//  Created by Nehemiah Horace on 4/5/17.
//  Copyright © 2017 Nehemiah Horace. All rights reserved.
//

import Foundation

struct cls_RPComment {
    
    fileprivate var _commentKey: String!
    fileprivate var _commentText: String!
    
    var commentKey: String {
        return _commentKey
    }
    
    var commentText: String {
        return _commentText
    }
    
    // Initialize the new Post
    
    init(key: String, commentDic: Dictionary<String, AnyObject>) {
        self._commentKey = key
        
        // Within the Post, or Key, the following properties are children
        
        if let comment = commentDic["comment"] as? String {
            self._commentText = comment
        }
    }
}
