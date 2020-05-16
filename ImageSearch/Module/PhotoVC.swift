//
//  PhotoVC.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    
    var rootView : PhotoView?
    var item:PhotoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: PhotoView.self)
        self.rootView = bundle.loadNibNamed("PhotoView", owner: self, options: nil)?.first as? PhotoView
        rootView!.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(rootView!)
        
        if let item = item {
            rootView?.bind(item)
        }
    }
}
