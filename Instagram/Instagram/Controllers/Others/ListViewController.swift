//
//  ListViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/16/21.
//

import UIKit

public enum UserRelationshipType {
    case following, not_following
}

public struct UserRelationship {
    let username: String
    let name: String
    let type: UserRelationshipType
}

class ListViewController: UIViewController {
    
    private var data = [UserRelationship]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowListTableViewCell.self, forCellReuseIdentifier: UserFollowListTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(data: [UserRelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowListTableViewCell.reuseIdentifier, for: indexPath) as? UserFollowListTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to profile of that user
        let _ = data[indexPath.row]
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}

extension ListViewController: UserFollowListTableViewCellDelegate {
    
    func didTapFollowUnfollowButton(_ model: UserRelationship) {
        print("Follow unfollow tapped")
        switch model.type {
        case .following:
            // Make firebase call to unfollow
            break
        case .not_following:
            // Make firebase call to follow
            break
        }
    }
    
}
