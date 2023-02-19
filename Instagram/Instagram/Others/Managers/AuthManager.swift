//
//  AuthManager.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    //MARK:- Public
    public func registerUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        print("Checking if the username and email combination is available through database...")
        DatabaseManager.shared.canCreateUser(with: email, username: username) { canCreate in
            if canCreate {
                print("Creating user with Auth...")
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard authResult != nil, error == nil else {
                        print("User creation failed in Auth")
                        completion(false)
                        return
                    }
                    print("Created User in Auth")
                    print("Inserting User in database...")
                    DatabaseManager.shared.insertUser(with: email, username: username) { inserted in
                        if inserted {
                            print("User inserted in database")
                            completion(true)
                        } else {
                            print("User insertion failed in database")
                            completion(false)
                        }
                    }
                }
            } else {
                print("Username/email not available.")
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        guard let email = email else {
            // Username based Auth
            print("UserName: \(username ?? "nil")")
            completion(false)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard authResult != nil, error == nil else {
                // Error
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print("Error while logging out")
            completion(false)
            return
        }
    }
    
}

