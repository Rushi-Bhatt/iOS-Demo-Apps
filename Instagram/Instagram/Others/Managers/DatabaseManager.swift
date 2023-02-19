//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let ref = Database.database().reference()
    
    /// Checks if username and email are available to create new user
    /// - Parameters:
    ///     - email: email provided by user
    ///     - username: username provied by user
    ///     - completion: completion block that takes in Bool and returns Void
    public func canCreateUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        // Check from Database if the username and email combination is available to use
        completion(true)
    }
    
    /// insert new user in the database
    /// - Parameters:
    ///     - email: email provided by user
    ///     - username: username provied by user
    ///     - completion: completion block that takes in Bool and returns Void
    public func insertUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        // Insert new user in the database
        // In Firebase, the keys cant have @ or . symbols so converting email to firebaseSafeString
        let safeEmail = email.firebaseSafeString
        ref.child(safeEmail).setValue(["username": username], withCompletionBlock: { (error, _) in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
}
