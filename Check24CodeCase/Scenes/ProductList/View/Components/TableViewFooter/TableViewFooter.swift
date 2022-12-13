//
//  TableViewFooter.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

class TableViewFooterView: UITableViewHeaderFooterView {
    
    private lazy var linkButton: UIButton = {
        let temp = UIButton()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    private var buttonAction: (() -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViewComponents() {
        contentView.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: linkButton.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: linkButton.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: linkButton.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: linkButton.trailingAnchor),
        ])
    }
    
    func setData(title: String, completion: @escaping () -> Void) {
        linkButton.setTitle(title, for: .normal)
        linkButton.setTitleColor(.blue, for: .normal)
        linkButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        buttonAction = completion
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        buttonAction?()
        debugPrint("asdfafdsafadsfs")
    }
}
