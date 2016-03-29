//
//  DataService.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/20/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://theshow.firebaseio.com"

class DataService {
    static let ds = DataService()
    
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }

    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
}
