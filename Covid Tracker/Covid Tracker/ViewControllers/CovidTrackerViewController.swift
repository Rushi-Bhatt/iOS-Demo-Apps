//
//  CovidTrackerViewController.swift
//  Covid Tracker
//
//  Created by Rushi Bhatt on 11/13/21.
//

import UIKit

class CovidTrackerViewController: UIViewController {

  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()
  
  private var scope: DataScope = .national
  private var dayWiseData: [DayWiseData] = [] {
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
  
  @objc private func didTapFilter() {
    let filterVc = FilterViewController()
    filterVc.delegate = self
    let navCon = UINavigationController(rootViewController: filterVc)
    present(navCon, animated: true, completion: nil)
  }
  
  fileprivate func setupFilter() {
    var filterTitle: String
    switch scope {
    case .national:
      filterTitle = "National"
    case .state(let state):
      filterTitle = state.name
    }
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: filterTitle, style: .done, target: self, action: #selector(didTapFilter))
  }
  
  private func fetchCovidData(for scope: DataScope = .national) {
    NetworkService.shared.getCovidData(for: scope) { [weak self] (result) in
      switch result {
      case .success(let dayWiseData):
        print(dayWiseData)
        self?.dayWiseData = dayWiseData
      case .failure(let error):
        print(error)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.title = "Covid Cases"
    setupTableView()
    setupFilter()
    fetchCovidData(for: .national)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }


}

extension CovidTrackerViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dayWiseData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dayData = dayWiseData[indexPath.row]
    let dateString:String = DateFormatter.dayFormatter.string(from: dayData.date)
    let casesString: String = NumberFormatter.numberFormatter.string(from: NSNumber(value: dayData.count)) ?? String(dayData.count)
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\(dateString): \(casesString) cases"
    return cell
  }
  
}

extension CovidTrackerViewController: FilterViewControllerDelegate {
  func viewController(vc: FilterViewController, didSelect state: State) {
    self.scope = .state(state)
    setupFilter()
    self.fetchCovidData(for: scope)
  }
  
}
