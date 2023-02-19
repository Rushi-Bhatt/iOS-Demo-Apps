//
//  ViewController.swift
//  TV Programming Exercise
//
//  Created by Jeffery Kuo on 12/17/19.
//  Copyright © 2019 Jeffery Kuo. All rights reserved.
//

import Alamofire
import PromiseKit
import UIKit

class PopularShowsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    fileprivate var shows = [TVShow]()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()

        firstly {
            getPopularTVShows()
        }.done { [weak self] in
            self?.shows = $0.results
            self?.tableView.reloadData()
        }.catch { [weak self] err in
            //Handle error here
        }
    }

    fileprivate func configureTableView() {
        tableView.tableFooterView = UIView()

        tableView.register(UINib(nibName: "ShowTableViewCell", bundle: nil), forCellReuseIdentifier: ShowTableViewCell.identifier)
    }

    /// API Spec: https://developers.themoviedb.org/3/tv/get-popular-tv-shows
    fileprivate func getPopularTVShows() -> Promise<PopularShowsResponse> {
        do {
            return try Alamofire.request(APIRouter.getPopularShows.asURLRequest()).responseDecodable(PopularShowsResponse.self)
        } catch (let error) {
            debugPrint(error)
        }
        return .init(error: SystemError.networkError)
    }
}

extension PopularShowsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.identifier, for: indexPath) as? ShowTableViewCell else { return UITableViewCell() }

        cell.showNameLabel.text = shows[indexPath.row].name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let showId = shows[indexPath.row].id
        let detailsViewController = DetailViewController(id: showId)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
