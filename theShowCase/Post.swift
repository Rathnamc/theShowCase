//
//  Post.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/29/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import Foundation

class Post {
    
    private var _postDescription: String!
    private var _imageUrl: String?
    private var _username: String!
    private var _postKey: String!
    private var _likes: Int!

    var postDescription: String! {
        return _postDescription
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var username: String! {
        return _username
    }
    
    var postKey: String! {
        return _postKey
    }
    
    var likes: Int! {
        return _likes
    }
    
    init(description: String, imageUrl: String?, username: String!) {
        self._postDescription = description
        self._imageUrl = imageUrl
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
        }
    }
    
}

