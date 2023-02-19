//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/15/21.
//

import UIKit

struct EditProfileCellModel {
    let label: String
    let placeHolder: String
    var value: String?
}

class EditProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView  = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private var model = [[EditProfileCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Edit Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        configureModels()
        tableView.tableHeaderView = configureHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4))
        headerView.backgroundColor = .systemBackground
        
        let profilePhotoButtonSize = headerView.height / 2
        let profilePhotoButton = UIButton(frame: CGRect(x: (headerView.width - profilePhotoButtonSize)/2,
                                                        y: (headerView.height - profilePhotoButtonSize)/2 ,
                                                        width: profilePhotoButtonSize,
                                                        height: profilePhotoButtonSize))
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = profilePhotoButtonSize / 2
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        profilePhotoButton.addTarget(self, action: #selector(didTapProfileIcon), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.tintColor = .secondaryLabel
        headerView.addSubview(profilePhotoButton)
        return headerView
    }
    
    private func configureModels() {
        // Section1: Name, Username, Bio
        let section1Labels = ["Name", "Username", "Bio"]
        var section1Models: [EditProfileCellModel] = []
        for label in section1Labels {
            let model = EditProfileCellModel(label: label, placeHolder: "Enter \(label)", value: nil)
            section1Models.append(model)
        }
        model.append(section1Models)
        
        //Section2: Email, Phone, Gender
        let section2Labels = ["Email", "Phone", "Gender"]
        var section2Models: [EditProfileCellModel] = []
        for label in section2Labels {
            let model = EditProfileCellModel(label: label, placeHolder: "Enter \(label)", value: nil)
            section2Models.append(model)
        }
        model.append(section2Models)
        print("model: \(model)")
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSave() {
        //Save information to database
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapProfileIcon() {
        // User wants to edit the profile picture
        let actionSheet = UIAlertController(title: "Choose Picture", message: "Change your profile picture", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Picture", style: .default, handler: { (_) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { (_) in
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
        
}

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else { return nil }
        return "Private Information"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.reuseIdentifier, for: indexPath) as? FormTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: model[indexPath.section][indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension EditProfileViewController: FormTableViewCellDelegate {
    func fieldTap(for cell: FormTableViewCell, didUpdate model: EditProfileCellModel) {
        print("new value for model is \(model)")
    }
}
