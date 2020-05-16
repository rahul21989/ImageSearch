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
    
//    private(set) var currentController:HomeController?
//    private(set) var item:OrderItem?
//    private(set) var disposeBag = DisposeBag()

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
            self.displayImageView.load(url: URL(string: item.largeImageURL ?? "")!)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        self.image = UIImage(named: "placeholder")
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }.resume()
    }
}
