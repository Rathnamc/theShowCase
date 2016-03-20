//
//  DataService.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/20/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    
    private var _REF_BASE = Firebase(url: "https://theshow.firebaseio.com")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }

}
