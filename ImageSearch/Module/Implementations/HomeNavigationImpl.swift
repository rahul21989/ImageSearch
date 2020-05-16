//
//  HomeNavigationImpl.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit

class HomeNavigationImpl: HomeNavigation {
    
    let viewController:UIViewController!
    
    init(_ contoller:UIViewController) {
        self.viewController = contoller
    }
    
    func routeToDetail(_ item: PhotoItem) {
        
        let vc = PhotoVC(nibName: "OrderDetailVC", bundle: nil)
        vc.item = item
        self.viewController?.present(vc, animated: false, completion: nil)
    }
    
    func showAlert() {

        // create the alert
        let alert = UIAlertController(title: "No Result Found", message: "Try with another string", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.viewController.present(alert, animated: true, completion: nil)
    }
}
