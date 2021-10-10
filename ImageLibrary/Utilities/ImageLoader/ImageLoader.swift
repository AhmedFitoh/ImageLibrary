//
//  ImageLoader.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit


extension UIImageView {
    /// Singleton cache variable
    var imageCache: NSCache<NSString, UIImage> {
        return ImageCacheManager.shared.imageCacher
    }

    /// Check if image is cached, if not it will be loaded and cached
    /// - Parameters:
    ///   - urlString: Url string
    ///   - cellIndexPathRow: used for reusables (UITableViewCell and UICollectionViewCells)
    ///   - placeHolderImage: placeholder image
    ///   - completionHandler: closure will be called after successfully setting image
    func loadImageUsingCache(withUrl urlString: String,
                             cellIndexPathRow: Int? = nil,
                             placeHolderImage: UIImage? = nil,
                             completionHandler: (()->())? = nil) {
        self.image = placeHolderImage
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedUrlString ) else {
            return
        }
        if let cellIndexPathRow = cellIndexPathRow {
            self.tag = cellIndexPathRow
        }
        // check cached image is already fetched
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            completionHandler?()
            return
        }
        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, _, error) in
            if error != nil {
                return
            }
            guard let data = data,
                  let image = UIImage(data: data) else {
                print ("Invalid image @ \(urlString)")
                return
            }
            self?.imageCache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {
                if let cellIndexPathRow = cellIndexPathRow{
                    if self?.tag != cellIndexPathRow {
                        return
                    }
                }
                self?.image = image
                completionHandler?()
            }
        }).resume()
    }
}


