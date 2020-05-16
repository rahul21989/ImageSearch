//
//  ItemCell.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!

//    var rootView : PhotoView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setup()
    }
//
//    private func setup() {
//        let bundle = Bundle(for: PhotoView.self)
//        self.rootView = bundle.loadNibNamed("PhotoView", owner: self, options: nil)?.first as? PhotoView
//        rootView!.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
//        addSubview(rootView!)
//    }
    
    public func bind(_ item:String, controller:HomeController) {
        self.label.text = item
    }
}


