//
//  HomeViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    // Horizontal CollectionView for the stories
    
    // Tableview for the feed
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // each feed has creator, feed picture/video, actions, and likes/comments -> 4 different cells
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func handleAuthentication() {
        //Check the auth status
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleAuthentication()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

