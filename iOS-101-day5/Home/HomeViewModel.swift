//
//  HomeViewModel.swift
//  iOS-101-day5
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol {
    var cellModels: [Any] { get }
    func loadData()
}

class HomeViewModel: HomeViewModelProtocol {
    unowned let viewController: HomeViewControllerProtocol
    
    init(viewController: HomeViewControllerProtocol) {
        self.viewController = viewController
    }
    
    var api: SearchBooksApiProtocol = SearchBooksApi()
    
    let pageSize = 10
    var start = 0
    var query: String = "我是传奇"
    
    var cellModels: [Any] = []
    
    func loadData() {
        api.searchBooks(q: query, start: start, count: pageSize) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.start = 0
                
                let totalCellModel = HomeTotalCellModel(total: response.total)
                let bookCellModels = response.books.map {
                    HomeBookCellModel(
                        image: URL(string: "\($0.images.small)?apikey=\(apiKey)")!,
                        title: $0.title,
                        author: $0.author
                    )
                }
                self.cellModels = [totalCellModel] + bookCellModels
                
                self.viewController.reloadTableView()
                self.viewController.stopPullToRefresh()
                
            case .failure(let error):
                self.viewController.showAlert(message: error.message)
            }
        }
    }
}
