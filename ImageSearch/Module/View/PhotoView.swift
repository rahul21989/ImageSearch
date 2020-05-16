//
//  PhotoView.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoView: UIView {
    
    @IBOutlet var displayImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        setUpGesture()
    }
    
    //    func setUpGesture()  {
    //        let tapGesture = UITapGestureRecognizer()
    //
    //        tapGesture.rx.event.bind(onNext: { recognizer in
    //            self.handleTap()
    //        }).disposed(by: disposeBag)
    //        addGestureRecognizer(tapGesture)
    //    }
    
    //    func handleTap () {
    //        self.currentController?.tap(item!)
    //    }
    
    func bind(_ item: PhotoItem?) {
        if let item = item {
            displayImageView.ad_setImageUrl(urlString: item.largeImageURL ?? "", placeholderImage: nil) { [weak self](image, error, imageUrl) in
                if error == nil {
                    self?.displayImageView?.contentMode = .scaleToFill
                }
            }
        }
    }
}
