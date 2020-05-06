//
//  HomeViewModelTests.swift
//  iOS-101-day5Tests
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit
import Quick
import Nimble
@testable import iOS_101_day5


class HomeViewModelTests: QuickSpec {
    
    var viewModel: HomeViewModel!
    var viewController: HomeViewControllerMock!
    var api: SearchBooksApiMock!
    
    override func spec() {
        beforeEach {
            self.viewController = HomeViewControllerMock()
            self.viewModel = HomeViewModel(viewController: self.viewController)
            self.api = SearchBooksApiMock()
            self.viewModel.api = self.api
        }
        
        
        describe("HomeViewModelTests") {
            it("table view should be reloaded when data is loaded successfully") {
                let responseMock = SearchBooksApi.Response(
                    total: 12,
                    count: 10,
                    books: [
                        SearchBooksApi.Response.Book(
                            title: "title",
                            author: ["author"],
                            images: SearchBooksApi.Response.Book.Images(small: URL(string: "https://img3.doubanio.com/view/subject/m/public/s2791630.jpg")!)
                        )
                    ]
                )
                self.api.searchBooksResult = .success(responseMock)
                
                self.viewModel.loadData()
                
                expect(self.viewModel.cellModels.count).to(equal(2))
                expect(self.viewController.didReloadTableView).to(beTrue())
                expect(self.viewController.didStopPullToRefresh).to(beTrue())
            }
            
            it("should do nothing when data load fails") {
                let responseMock = ApiError(message: "this is a error message.")
                self.api.searchBooksResult = .failure(responseMock)
                
                self.viewModel.loadData()
                
                expect(self.viewModel.cellModels).to(beEmpty())
                expect(self.viewController.didStopPullToRefresh).to(beTrue())
                expect(self.viewController.didShowAlert).to(beTrue())
            }
        }
    }
}
