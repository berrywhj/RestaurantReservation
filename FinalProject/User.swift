//
//  User.swift
//  FinalProject
//
//  Created by Berry on 3/9/24.
//

import Foundation

var userInstance = User(name: "", phone: "", email: "")

class User {
    var name: String
    var phone: String
    var email: String
    
    init(name: String, phone: String, email: String) {
        self.name = name
        self.phone = phone
        self.email = email
    }
}
