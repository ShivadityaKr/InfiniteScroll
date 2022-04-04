//
//  LazyImageView.swift
//  Pagnination fetch api
//
//  Created by Shivaditya Kumar on 17/02/22.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func loadImage(fromURL imageURL: URL, placeHolderImage: String){
        self.image = UIImage(named: placeHolderImage)
    
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject){
            debugPrint("image is loaded from cache !!")
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            if let imageData = try?Data(contentsOf: imageURL){
                if let image = UIImage(data: imageData){
                    DispatchQueue.main.async {
                        debugPrint("image is downloaded !!")
                        self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
