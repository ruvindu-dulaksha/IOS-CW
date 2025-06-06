//
//  LoginModel.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-06.
//

import Foundation

struct UserModel {
    let email: String
    let password: String
}   

class UserStorage {
    static let shared = UserStorage()
    
    private(set) var users: [UserModel] = [
        UserModel(email: "dulaksha@student.nibm.lk", password: "Dulaksha@123"),
        UserModel(email: "ruvindu@lecturer.nibm.lk", password: "Ruvindu@123")
    ]
    
    private init() {}
    
    func addUser(_ user: UserModel) {
        users.append(user)
    }
    
    func validateUser(email: String, password: String) -> Bool {
        users.contains { $0.email == email && $0.password == password }
    }
}
