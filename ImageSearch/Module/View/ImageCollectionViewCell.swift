//
//  ImageCollectionViewCell.swift
//  ImageSearch
//
//  Created by Rahul Goyal on 15/05/20.
//  Copyright © 2020 Rahul Goyal. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static let nibName = "ImageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func bind(_ item:PhotoItem, controller:HomeController) {
        imageView.ad_setImageUrl(urlString: item.largeImageURL ?? "", placeholderImage: nil) { [weak self](image, error, imageUrl) in
            if error == nil {
                self?.imageView?.contentMode = .scaleToFill
            }
        }
    }
}

extension UIImageView {
    func ad_setImageUrl(urlString: String, placeholderImage: UIImage?, completionBlock: @escaping ((UIImage?, Error?, String?) -> Void)) {
        if let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodedUrl) {
            self.sd_setImage(with: url, placeholderImage: placeholderImage, options: .highPriority) { [weak self] (image, error, _, imageUrl) in
                if (image != nil) {
                    DispatchQueue.main.async {
                         self?.image = image
                    }
                }
                completionBlock(image, error, imageUrl?.absoluteString)
            }
        }
    }
}




