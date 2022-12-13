//
//  ImageCacheManager.swift
//  Marvel Code Case
//
//  Created by DarkBringer on 3.12.2021.
//

import UIKit

//MARK: - A manager to cache and retreive images from cache memory. If this didnt exist, images would take up space in RAM.

class ImageCacheManager {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    class func setImagesToCache(object: UIImage, key: String) {
        imageCache.setObject(object, forKey: NSString(string: key))
    }
    
    class func returnImagesFromCache(key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
}
