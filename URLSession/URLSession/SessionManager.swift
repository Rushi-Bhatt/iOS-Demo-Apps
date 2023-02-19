//
//  SessionManager.swift
//  URLSession
//
//  Created by Rushi Bhatt on 8/19/21.
//

import Foundation

protocol SessionManagerDownloadDelegate {
    func sessionManager(_ :SessionManager, didStoreDownload at: URL)
}

class SessionManager: NSObject {
 
    static let shared = SessionManager()
    var downloadTask: URLSessionDownloadTask?
    var downloadLocation: URL?
    var delegate: SessionManagerDownloadDelegate?
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }()
    
    // Uses delegate methods as there is no completion handler argument 
    func downloadImage(with url: URL) {
        downloadTask = session.downloadTask(with: url)
        downloadTask?.resume()
    }
    
    // Uses completion handlers, delegate methods wont be called even though we set the delegate to self.
    func downloadImage(with url: URL, completion: @escaping (Data) -> Void) {
        downloadTask = session.downloadTask(with: url) { (location, response, error) in
            guard let location = location,
                  error == nil,
                  let imageData = try? Data(contentsOf: location)  else {
                fatalError() }
            
            DispatchQueue.main.async {
                print("Calling completion handler with data")
                completion(imageData)
            }
        }
        downloadTask?.resume()
    }
}

extension SessionManager: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Error while downloading: \(error.localizedDescription)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download finished .. delegate methods called")
        let fm = FileManager.default
        guard let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
        let destinationUrl = documentDirectory.appendingPathComponent("URLSessionImage.jpg")
        do {
            if fm.fileExists(atPath: destinationUrl.path) {
                try fm.removeItem(at: destinationUrl)
            }
            try fm.copyItem(at: location, to: destinationUrl) // Copying from termporary location to permanent location
            DispatchQueue.main.async {
                self.downloadLocation = destinationUrl
                print("download location: \(self.downloadLocation?.absoluteString ?? "nil")")
                self.delegate?.sessionManager(self, didStoreDownload: destinationUrl)
            }
        } catch {
            print(error)
        }
        
        
    }
}
