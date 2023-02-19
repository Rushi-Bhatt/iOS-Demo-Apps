//
//  ImageDownloader.swift
//  URLSession
//
//  Created by Rushi Bhatt on 1/29/23.
//

import Foundation
import UIKit

final class ImageDownloader {
    
    // Thread-Unsafe dictionaries used as cache, so we will make it thread-safe while using
    // alternatively can also use NSCache which is thread-safe but it has unclear eviction process.
    private var imageCache: [String: UIImage]
    private var taskCache: [String: URLSessionDataTask]
    
    private let imageCacheQueue: DispatchQueue = .init(label: "imageQueue", attributes: .concurrent)
    private let taskCacheQueue: DispatchQueue = .init(label: "taskQueue", attributes: .concurrent)
    
    init() {
        self.imageCache = [:]
        self.taskCache = [:]
    }
    
    func download(from urlString: String?, placeholder: UIImage?, completion: @escaping ((UIImage?, Bool) -> ())) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(placeholder, true)
            }
            return
        }
        
        // check if the image is already in cache
        if let cachedImage = getImageFromCache(url: urlString) {
            DispatchQueue.main.async {
                completion(cachedImage, true)
            }
            return
        }
        
        // check if the download task is not already in progress
        if let _ = getTaskFromCache(url: urlString) {
            return
        }
        
        let task = URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(placeholder, true)
                }
                return
            }
            
            let image = UIImage(data: data)
            
            // store the image in cache
            // writing to the cache should be thread-safe
            self.imageCacheQueue.sync(flags: .barrier) {
                self.imageCache[urlString] = image
            }
            
            // remove the task from cache since its complete now
            // writing to the cache should be thread-safe
            _ = self.taskCacheQueue.sync(flags: .barrier) {
                self.taskCache.removeValue(forKey: urlString)
            }
            
            // finally call the completion handler
            DispatchQueue.main.async {
                completion(image, false)
            }
        }
        
        // add the task in cache so other paraller download cant happen
        // writing to the cache should be thread-safe
        taskCacheQueue.sync(flags: .barrier) {
            taskCache[urlString] = task
        }
        
        task.resume()
    }
}

extension ImageDownloader {
    
    private func getImageFromCache(url: String) -> UIImage? {
        // Reading from the dictionary should happen in the thread-safe manner
        imageCacheQueue.sync {
            return imageCache[url]
        }
    }
    
    private func getTaskFromCache(url: String) -> URLSessionDataTask? {
        // Reading from the dictionary should happen in the thread-safe manner
        taskCacheQueue.sync {
            return taskCache[url]
        }
    }
    
    private func cancelPreviousTask(with urlString: String?) {
        if let urlString = urlString, let task = getTaskFromCache(url: urlString) {
            task.cancel()
            // Since Swift dictionaries are not thread-safe, we have to explicitly set this barrier to avoid fatal error when it is accessed by multiple threads simultaneously
            _ = taskCacheQueue.sync(flags: .barrier) {
                taskCache.removeValue(forKey: urlString)
            }
        }
    }
}
