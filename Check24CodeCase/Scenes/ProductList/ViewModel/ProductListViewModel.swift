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
}

class ProductListViewModel: NSObject, ProductListViewModelProtocol {
    
    private var dataFormatter: ProductListDataFormatter
    private var mainViewState: ((MainViewState) -> Void)?

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
    
    func subscribeViewState(with completion: @escaping (MainViewState) -> Void) {
        mainViewState = completion
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
}

enum MainViewState {
    case loading
    case done
}
