//
//  ImageCacheManager.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    let imageCacher: NSCache<NSString, UIImage>
    private init() {
        self.imageCacher = NSCache<NSString, UIImage>()
    }
}
