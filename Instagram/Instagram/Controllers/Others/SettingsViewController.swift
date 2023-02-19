//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/12/21.
//

import UIKit
import SafariServices

struct SettingsCellViewModel {
    var title: String
    var handler: (() -> ())
}

class SettingsViewController: UIViewController {
    
    private var data =  [[SettingsCellViewModel]]()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDataModel()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureDataModel() {
        self.data = [
            [
                SettingsCellViewModel(title: "Edit Profile", handler: {
                    self.didTapEditProfile()
                }),
                SettingsCellViewModel(title: "Invite Friends", handler: {
                    self.didTapInviteFriends()
                }),
                SettingsCellViewModel(title: "Save Original Posts", handler: {
                    self.didTapSaveOriginalPosts()
                })
            ],
            [
                SettingsCellViewModel(title: "Terms of Service", handler: {
                    self.didTapOpenUrl(type: .terms)
                }),
                SettingsCellViewModel(title: "Privacy Policy", handler: {
                    self.didTapOpenUrl(type: .privacy)
                }),
                SettingsCellViewModel(title: "Help", handler: {
                    self.didTapOpenUrl(type: .help)
                })
            ],
            [
                SettingsCellViewModel(title: "Log Out", handler: {
                    self.didTapLogout()
                })
            ],
            
        
        ]
    }
}

// MARK:- TableView delegate and datasource
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
    
}

// MARK:- Tap handlers
extension SettingsViewController {
    
    private enum URLType: String {
        case terms = "https://help.instagram.com/581066165581870"
        case privacy = "https://help.instagram.com/519522125107875/"
        case help = "https://help.instagram.com"
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
    }
    
    private func didTapInviteFriends() {
        // show share VC
    }
    
    private func didTapSaveOriginalPosts() {
        // Save original posts
    }
    
    private func didTapOpenUrl(type: URLType) {
        guard let url = URL(string: type.rawValue) else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapLogout() {
        // First show the confirmation action sheet
        let actionSheet = UIAlertController(title: "Log Out of your account", message: "Are you sure?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            print("Loggin out user...")
            AuthManager.shared.logOut { (success) in
                DispatchQueue.main.async {
                    if success {
                        print("User logged out successfully")
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            // Dismiss Settings VC, and navigate back to HomeVC
                            // So next time if user logs in, he/she sees HomeVC
                            self.navigationController?.popViewController(animated: true)
                            self.navigationController?.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        print("Log out failed")
                        fatalError("Log out failed")
                    }
                }
            }
        }))
        present(actionSheet, animated: true, completion: nil)
    }
}
