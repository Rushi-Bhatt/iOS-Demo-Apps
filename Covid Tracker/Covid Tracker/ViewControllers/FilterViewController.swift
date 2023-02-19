//
//  FilterViewController.swift
//  Covid Tracker
//
//  Created by Rushi Bhatt on 11/13/21.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
  
  func viewController(vc: FilterViewController, didSelect state: State)
  
}

class FilterViewController: UIViewController {

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()
  
  private var states: [State] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  fileprivate func setupTableView() {
    view.addSubview(tableView)
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  @objc private func didTapClose() {
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func setupClose() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
  }
  
  private func fetchStatesData() {
    NetworkService.shared.getAllStates { [weak self] (result) in
      switch result {
      case .success(let states):
        self?.states = states
      case .failure(let error):
        print(error)
      }
    }
  }
  
  weak var delegate: FilterViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.title = "Select state"
    setupTableView()
    setupClose()
    fetchStatesData()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return states.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let state = states[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = state.name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let state = states[indexPath.row]
    delegate?.viewController(vc: self, didSelect: state)
    dismiss(animated: true, completion: nil)
  }
  
}

