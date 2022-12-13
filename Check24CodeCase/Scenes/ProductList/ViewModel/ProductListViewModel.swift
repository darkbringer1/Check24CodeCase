//
//  ProductListViewModel.swift
//  Check24CodeCase
//
//  Created by Doğukaan Kılıçarslan on 13.12.2022.
//

import Foundation
import DefaultNetworkOperationPackage
import UIKit

typealias ProductListResponseBlock = (Result<ProductListResponseModel, ErrorResponse>) -> Void

protocol ProductListViewModelProtocol: UITableViewDataSource, UITableViewDelegate {
    func getProductList()
    func subscribeViewState(with completion: @escaping (MainViewState) -> Void)
    func filterProducts(for index: Int)
    func navigateToWebview() -> UIViewController?
    func subscribeWebviewTap(with completion: @escaping () -> Void)
    func subscribeToDetailViewState(with completion: @escaping (Product) -> Void)
}

class ProductListViewModel: NSObject, ProductListViewModelProtocol {
    
    private var dataFormatter: ProductListDataFormatter
    private var mainViewState: ((MainViewState) -> Void)?
    private var voidCompletion: (() -> Void)?
    private var detailViewState: ((Product) -> Void)?
    
    init(dataFormatter: ProductListDataFormatter) {
        self.dataFormatter = dataFormatter
    }
    
    func getProductList() {
        mainViewState?(.loading)
        do {
            guard let urlRequest = try? ProductListServiceProvider(request: EmptyRequestModel()).returnUrlRequest(headerType: .contentTypeUTF8) else { return }
            debugPrint(urlRequest)
            fireApiCall(with: urlRequest, dataListener: dataListener)
        }
    }
    
    func navigateToWebview() -> UIViewController? {
        guard let url = dataFormatter.getFooterValue() else { return nil }
        return dataFormatter.navigateToWebview(with: url)
    }

    func subscribeWebviewTap(with completion: @escaping () -> Void) {
        voidCompletion = completion
    }
    
    func subscribeViewState(with completion: @escaping (MainViewState) -> Void) {
        mainViewState = completion
    }
    
    func subscribeToDetailViewState(with completion: @escaping (Product) -> Void) {
        detailViewState = completion
    }
    
    private func fireApiCall(with urlRequest: URLRequest, dataListener: @escaping ProductListResponseBlock) {
        APIManager.shared.executeRequest(urlRequest: urlRequest, completion: dataListener)
    }
    
    private lazy var dataListener: (Result<ProductListResponseModel, ErrorResponse>) -> Void = { [weak self] result in
        switch result {
            case .success(let data):
                self?.dataFormatter.setData(with: data)
                self?.mainViewState?(.done)
                debugPrint(data)
            case .failure(let error):
                debugPrint(error)
        }
    }
    
    func filterProducts(for index: Int) {
        mainViewState?(.loading)
        switch index {
            case 0:
                getProductList()
            case 1:
                dataFormatter.filterAvailableProducts()
            case 2:
                dataFormatter.filterFavouriteProducts()
            default:
                break
        }
        mainViewState?(.done)
    }
}

extension ProductListViewModel: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataFormatter.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseIdentifier, for: indexPath) as? ProductListTableViewCell else { return UITableViewCell() }
        let data = dataFormatter.getItem(at: indexPath.row)
        cell.configureCell(with: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderView.reuseIdentifier) as? TableViewHeaderView else { return nil }
        headerView.setData(title: dataFormatter.getHeaderValues().0, subtitle: dataFormatter.getHeaderValues().1)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewFooterView.reuseIdentifier) as? TableViewFooterView else { return nil }
        footerView.setData(title: dataFormatter.getFooterValue()?.absoluteString ?? "") { [weak self] in
            self?.voidCompletion?()
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailViewState?(dataFormatter.getItem(at: indexPath.row))
    }
}

enum MainViewState {
    case loading
    case done
}
