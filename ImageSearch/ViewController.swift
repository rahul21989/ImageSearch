//
//  ViewController.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController{

    @IBOutlet var rootView :HomeRootView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOrders()
    }
    
    private func setUpOrders() {
        let presenter = HomePresenter(viewData: HomeViewData(), homeNavigation: HomeNavigationImpl(self))
        let interactor = HomeInteractor(dataGateway: DataGatewayImpl(), connectionGateway: ConnectionGatewayImpl())
        let controller = HomeController(homeInteractor: interactor, presenter: presenter);
        self.rootView.bind(controller: controller)
    }
}

