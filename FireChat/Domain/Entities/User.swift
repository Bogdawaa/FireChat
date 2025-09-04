//
//  User.swift
//  FireChat
//
//  Created by Bogdan Fartdinov on 15.08.2025.
//

import Foundation

struct User: Identifiable {
    let id: String
    let name: String
    let email: String
    let profileURL: URL?
}

extension User {
    static let mock = User(
        id: "1",
        name: "Bogdan",
        email: "bogdan@gmail.com",
        profileURL: nil
    )
}
