//
//  CustomImageViewComponentContainer.swift
//  Marvel Code Case
//
//  Created by DarkBringer on 3.12.2021.
//

import UIKit
import BaseComponents

class CustomImageViewComponentContainer: GenericBaseView<CustomImageViewComponentData> {
    
    private lazy var customImageView: CustomImageViewComponent = {
        let temp = CustomImageViewComponent()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.clipsToBounds = true
        temp.layer.cornerRadius = 8
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    override func addViewComponents() {
        super.addViewComponents()
        addCustomImageView()
    }
    
    private func addCustomImageView() {
        addSubview(customImageView)
        
        NSLayoutConstraint.activate([
            
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customImageView.topAnchor.constraint(equalTo: topAnchor),
            customImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    override func loadDataView() {
        super.loadDataView()
        guard let data = getData() else { return }
        customImageView.setData(componentData: data)
        customImageView.contentMode = data.contentMode
    }
    
}
