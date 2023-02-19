//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/9/21.
//

import UIKit

//Design:
// CollectionView:
// Section1:
// - header: ProfileInfoHeader
// - cells: 0

// Section2:
// - header: ProfileTabHeader
// - cells: # of posts
class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var userPosts = [UserPost]()
    private var data: [UserRelationship] = [
        UserRelationship(username: "joe1", name: "@joe1", type: .following),
        UserRelationship(username: "joe2", name: "@joe2", type: .not_following),
        UserRelationship(username: "joe3", name: "@joe3", type: .following),
        UserRelationship(username: "joe4", name: "@joe4", type: .not_following),
        UserRelationship(username: "joe5", name: "@joe5", type: .following)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         
        //Registration: Cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
       
        //Registration: Headers
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.reuseIdentifier)
        
        collectionView?.register(ProfileTabHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabHeaderCollectionReusableView.reuseIdentifier)

        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapSettingsButton))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height / 3)
        } else {
            return CGSize(width: collectionView.width, height: 65.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let profileInfoHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            profileInfoHeader.delegate = self
            return profileInfoHeader
        } else {
            let profileTabHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabHeaderCollectionReusableView.reuseIdentifier, for: indexPath) as! ProfileTabHeaderCollectionReusableView
            profileTabHeader.delegate = self
            return profileTabHeader
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 30
       // return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
//        let post = userPosts[indexPath.row] // Notice how we dont care about section, as this will only be called for section which has rows (i.e. not for section 0, but only for section 1)
//        cell.configureCell(with: post)
        cell.configureCell(with: "test")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let post = userPosts[indexPath.row]
        let postVC = PostViewController(post: nil)
        postVC.title = "Posts"
        navigationController?.pushViewController(postVC, animated: true)
    }
    
}

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // Scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // Show List View Controller
        let listVC = ListViewController(data: data)
        listVC.title = "Followers"
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // Show List View Controller
        let listVC = ListViewController(data: data)
        listVC.title = "Following"
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // Show Edit Profile View Controller
        let editVC = EditProfileViewController()
        let navVC = UINavigationController(rootViewController: editVC)
        present(navVC, animated: true, completion: nil)
    }

}

extension ProfileViewController: ProfileTabHeaderCollectionReusableViewDelegate {
    
    func profileTabHeaderDidTapGridTabButton(_ header: ProfileTabHeaderCollectionReusableView) {
        //Refresh collection View with user posts
    }
    
    func profileTabHeaderDidTapTaggedTabButton(_ header: ProfileTabHeaderCollectionReusableView) {
        //Refresh collection View with tagged posts
    }
    
    
}
