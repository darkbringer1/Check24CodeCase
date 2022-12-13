//
//  ProductListTableViewCell.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingStartStackView: UIStackView!
    
    func configureCell(with productData: Product) {
        titleLabel.text = productData.name
        dateLabel.text = productData.releaseDate?.asDate.asString
        priceLabel.text = "Price: " + productData.formattedPrice
        descriptionLabel.text = productData.longDescription
        productImageView.image = UIImage(systemName: "star.fill")
        setRatingStars(ratingCount: Int(productData.rating ?? 0))
    }
    
    private func setRatingStars(ratingCount: Int) {
        ratingStartStackView.subviews.forEach({ $0.removeFromSuperview() })
        for _ in 1...ratingCount {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            starImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            ratingStartStackView.addArrangedSubview(starImageView)
        }
        for _ in ratingCount..<5 {
            let emptyStarImageView = UIImageView(image: UIImage(systemName: "star"))
            emptyStarImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            emptyStarImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            ratingStartStackView.addArrangedSubview(emptyStarImageView)
        }
    }
}
