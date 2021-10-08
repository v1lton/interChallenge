//
//  UserViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 07/10/21.
//

import Foundation

public class UserViewModel {
    let id: Int
    let initialsLabel: String
    let nameLabel: String
    let userNameLabel: String
    let emailLabel: String
    let phoneLabel: String
    
    init(user: User) {
        self.id = user.id
        self.initialsLabel = String(user.name.prefix(2))
        self.nameLabel = user.name
        self.userNameLabel = user.username
        self.emailLabel = user.email
        self.phoneLabel = user.phone
    }
    
}

