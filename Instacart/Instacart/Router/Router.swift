//
//  Router.swift
//  Instacart
//
//  Created by Rushi Bhatt on 1/24/23.
//

import Foundation
import UIKit

protocol RoutingProtocol {
    func instantiateRootViewController() -> UIViewController
    func navigateToDummyVC()
}

class Router: RoutingProtocol {
    
    private var navigationController: UINavigationController
    private let service: ServiceProtocol
    
    init(service: ServiceProtocol = Service()) {
        self.navigationController = UINavigationController()
        self.service = service
    }
    
    func instantiateRootViewController() -> UIViewController {
        let service = Service()
        let homeVM = ViewModel(service: service, router: self)
        let homeVC = ViewController(viewModel: homeVM)
        navigationController.viewControllers = [homeVC]
        return navigationController
    }
    
    func navigateToDummyVC() {
        let dummyVC = UIViewController()
        navigationController.pushViewController(dummyVC, animated: true)
    }
}
