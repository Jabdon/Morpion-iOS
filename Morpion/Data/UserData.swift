//
//  UserData.swift
//  Morpion
//
//  Created by Jonathan on 5/5/18.
//  Copyright © 2018 Ansilans. All rights reserved.
//

import Foundation

struct UserData {
    let userID: Int
    let username: String
    var email: String?
    var profileImage: String?
    var numberOfWins: Int?
    var numberOfLosses: Int?
    
    init(userID: Int, username: String) {
        self.userID = userID
        self.username = username
    }
}
