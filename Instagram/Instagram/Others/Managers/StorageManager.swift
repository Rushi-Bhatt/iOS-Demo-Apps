//
//  StorageManager.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    
    let bucket = Storage.storage().reference()
    
    public func uploadUserPost(post: UserPost, completion:  @escaping (Result<URL, FeedError>) -> Void) {
    
    }
    
    public func downloadPost(by reference: String, completion: @escaping (Result<URL, FeedError>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url, error == nil else {
                completion(.failure(FeedError.failedToDownload))
                return
            }
            completion(.success(url))
            return
        }
    }
}

public enum FeedError: Error {
    case failedToPost
    case failedToDownload
}
