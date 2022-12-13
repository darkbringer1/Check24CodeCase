//
//  ProductDetailViewController.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit
import BaseComponents

class ProductDetailViewController: UIViewController {
    var viewModel: ProductDetailViewModel
    
    @IBOutlet weak var productImageView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var longDescriptionTitleLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!
    
    // MARK: Initializers
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductDetailViewController.self), bundle: .main)
    }
    
    required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    private func setData() {
        let data = viewModel.getProductData()
        addImage(with: data.imageURL)
        nameLabel.text = data.name
        priceLabel.text = "Price: " + data.formattedPrice
        setRatingStars(ratingCount: Int(data.rating ?? 0))
        dateLabel.text = data.releaseDate?.asDate.asString
        shortDescriptionLabel.text = data.productDescription
        longDescriptionLabel.text = data.longDescription
        footerLabel.text = "© 2016 Check24"
    }
    
    private func addImage(with url: String?) {
        guard let url = url else { return }
        productImageView.subviews.forEach({$0.removeFromSuperview()})
        let customImage = CustomImageViewComponentContainer()
        customImage.translatesAutoresizingMaskIntoConstraints = false
        customImage.setData(by: CustomImageViewComponentData(imageUrl: url))
        productImageView.addSubview(customImage)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: customImage.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: customImage.bottomAnchor),
            productImageView.leadingAnchor.constraint(equalTo: customImage.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: customImage.trailingAnchor),
        ])
    }
    
    private func setRatingStars(ratingCount: Int) {
        ratingStackView.subviews.forEach({ $0.removeFromSuperview() })
        for _ in 1...ratingCount {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            starImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            ratingStackView.addArrangedSubview(starImageView)
        }
        for _ in ratingCount..<5 {
            let emptyStarImageView = UIImageView(image: UIImage(systemName: "star"))
            emptyStarImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            emptyStarImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            ratingStackView.addArrangedSubview(emptyStarImageView)
        }
    }
    
    @IBAction func favouriteButtonAction(_ sender: Any) {
    }
}
