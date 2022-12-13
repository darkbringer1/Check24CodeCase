//
//  ProductListViewController.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var viewModel: ProductListViewModelProtocol
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
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
        setupTableView()
        subscribeViewModel()
        setupSegmentControl()
        viewModel.getProductList()
    }
    
    func setupTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.register(UINib(nibName: ProductListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
        tableView.register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewHeaderView.reuseIdentifier)
        tableView.register(TableViewFooterView.self, forHeaderFooterViewReuseIdentifier: TableViewFooterView.reuseIdentifier)
        tableView.estimatedRowHeight = 200
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func setupSegmentControl() {
        segmentControl.addTarget(self, action: #selector(segmentChange(_:)), for: .valueChanged)
    }
    
    @objc func segmentChange(_ sender: UISegmentedControl) {
        viewModel.filterProducts(for: sender.selectedSegmentIndex)
    }
    
    @objc func refreshData() {
        viewModel.getProductList()
        tableView.refreshControl?.endRefreshing()
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func subscribeViewModel() {
        viewModel.subscribeViewState { [weak self] state in
            switch state {
                case .loading:
                    break
                case .done:
                    self?.reloadTableViewData()
            }
        }
        viewModel.subscribeWebviewTap { [weak self] in
            guard let vc = self?.viewModel.navigateToWebview() else { return }
            self?.navigationController?.present(vc, animated: true)
        }
    }
}
