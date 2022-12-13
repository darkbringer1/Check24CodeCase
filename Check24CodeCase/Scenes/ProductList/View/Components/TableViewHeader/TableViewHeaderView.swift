//
//  TableViewHeaderView.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

class TableViewHeaderView: UITableViewHeaderFooterView {
    
    
    private lazy var mainStackView: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.axis = .vertical
        temp.alignment = .leading
        return temp
    }()
    
    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViewComponents() {
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
        ])
    }
    
    func setData(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
