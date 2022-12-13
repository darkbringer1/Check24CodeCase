//
//  ProductListViewController.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var viewModel: ProductListViewModelProtocol
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Initializers
    init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductListViewController.self), bundle: .main)
    }
    
    required init?(coder _: NSCoder) {
        return nil
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        viewModel.getProductList()
    }
}
