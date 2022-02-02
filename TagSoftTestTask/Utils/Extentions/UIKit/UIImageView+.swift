//
//  UIImageView+.swift
//  TagSoftTestTask
//
//  Created by Raushan Ruslan kyzy on 20/1/22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func load(urlString: String) {
        if let image = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = image
        } else {
            if let url = URL(string: urlString) {
                DispatchQueue.global(qos: .utility).async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.image = image
                                imageCache.setObject(image, forKey: urlString as AnyObject)
                            }
                        }
                    }
                }
            }
        }
    }
}
