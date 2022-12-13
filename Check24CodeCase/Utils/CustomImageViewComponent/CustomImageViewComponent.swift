//
//  CustomImageViewComponent.swift
//  Marvel Code Case
//
//  Created by DarkBringer on 3.12.2021.
//

import UIKit

class CustomImageViewComponent: UIImageView {
    
    private var imageUrlString: String?
    
    func setData(componentData: CustomImageViewComponentData) {
        DispatchQueue.main.async { [weak self] in
            self?.imageLoadingProcess(componentData: componentData)
        }
    }
    
    //MARK: - GETTING THE IMAGE FROM THE CACHE OR INTERNET
    
    private func imageLoadingProcess(componentData: CustomImageViewComponentData) {
        imageUrlString = componentData.imageUrl
        
        //empty the view which the image was inside- prevent override or visual bugs
        image = nil
        
        
        //if its cached, set image to image else next step --->>
        if let cachedImage = returnImageFromCache(imageUrl: componentData.imageUrl) {
            image = cachedImage
            return
        }
        //if its not cached, download from internet with private method.
        guard let url = URL(string: componentData.imageUrl) else { return }
        fireImageDownloadingRequest(url, componentData)
    }
    
    //MARK: - DOWNLOAD THE IMAGE
    
    //try to download the image with URLSession task
    private func fireImageDownloadingRequest(_ url: URL, _ componentData: CustomImageViewComponentData) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error in image download request: \(String(describing: error))")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.handleTaskResponse(data: data, componentData: componentData)
            }
        }.resume()
    }
    
    
    //MARK: - TASK RESPONSE HANDLERS
    
    //Checking the image with a url and putting the image inside a view
    private func handleTaskResponse(data: Data?, imageUrl: String) {
        guard let data = data, let image = UIImage(data: data) else { return }
        
        //if there is an image, put it on the view with animation
        if self.imageUrlString == imageUrl {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
                self?.image = image
            }
        }
        //need to set image to cache if it is downloaded
        setImageToCache(key: imageUrl, object: image)
    }
    
    //checking the image from Component data and putting it in the cache
    private func handleTaskResponse(data: Data?, componentData: CustomImageViewComponentData) {
        guard let data = data, let image = UIImage(data: data) else { return }
        
        if self.imageUrlString == componentData.imageUrl {
            UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
                self?.image = image
            }
        }
        //need to set image to cache if it exist inside the component data
        setImageToCache(key: componentData.imageUrl, object: image)
    }
    
    //MARK: - SETTING IMAGE TO CACHE
    
    //setting downloaded image to cache
    private func setImageToCache(key: String, object: UIImage) {
        ImageCacheManager.setImagesToCache(object: object, key: key)
    }
    
    //MARK: - RETURNING THE IMAGE FROM THE CACHE
    
    private func returnImageFromCache(imageUrl: String) -> UIImage? {
        guard let cachedImage = ImageCacheManager.returnImagesFromCache(key: imageUrl) else { return nil }
        return cachedImage
    }
    
}
