//
//  DetailViewController.swift
//  TV Programming Exercise
//
//  Created by Jeffery Kuo on 4/16/21.
//  Copyright © 2021 Jeffery Kuo. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit

class DetailViewController: UIViewController {
    
    private var showId: Int?
    
    init(id: Int) {
        self.showId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Show Details"

        firstly {
            getTVShowDetail(id: self.showId ?? 0)
        }.done { showDetails in
            print(showDetails)
        }.catch { err in
            
        }
    }

    /// API Spec: https://developers.themoviedb.org/3/tv/get-tv-details
    fileprivate func getTVShowDetail(id: Int) -> Promise<TVShowDetails> {
        do {
            return try Alamofire.request(APIRouter.getShowDetails(id: id).asURLRequest()).responseDecodable(TVShowDetails.self)
        } catch (let error) {
            debugPrint(error)
        }
        
        return .init(error: NSError.init())
    }
    
}
