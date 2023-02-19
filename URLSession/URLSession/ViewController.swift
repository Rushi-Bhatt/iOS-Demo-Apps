//
//  ViewController.swift
//  URLSession
//
//  Created by Rushi Bhatt on 8/19/21.
//

import UIKit

class ViewController: UIViewController, SessionManagerDownloadDelegate {

    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download Image", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(didTapDownload), for: .touchUpInside)
        return button
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload json", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(didTapUpload), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(downloadButton)
        view.addSubview(uploadButton)
        addConstraints()
    }

    private func addConstraints() {
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
    
     
        downloadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        downloadButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        downloadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        uploadButton.topAnchor.constraint(equalTo: downloadButton.bottomAnchor).isActive = true
        uploadButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        uploadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func didTapDownload() {
        guard let url = URL(string: "https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_2500kB.jpg") else { return }
        let sessionManager = SessionManager()
        sessionManager.delegate = self
        
        // sessionManager.downloadImage(with: url) -> To download image using URLSessionDownloadDelegate methods
        
        sessionManager.downloadImage(with: url) { (data) in
            let image = UIImage(data: data)
            self.imageView.image = image
        }
    }
    
    @objc func didTapUpload() {
        print("Turn on Vapor server to connect to localhost...")
        
        
        let json = """
        {
            "name" : "Learning Swift",
            "author": "Rushi",
            "version": 1.0
        }
        """
        guard let uploadURL = URL(string: "http://localhost:8080/upload") else { fatalError() }
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "Post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = json.data(using: .utf8)
        
        let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        urlSession.uploadTask(with: request, from: jsonData) { (data, resonse, error) in
            print("response: \(resonse ?? nil)")
        }.resume()
    }
    
    // MARK: Delegate
    func sessionManager(_: SessionManager, didStoreDownload at: URL) {
        print("trying to load image view")
        guard let data = try? Data(contentsOf: at), let image = UIImage(data: data) else { return }
        print("loading imageview...")
        self.imageView.image = image
    }
}

