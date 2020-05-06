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
    
    override func spec() {
        beforeEach {
            self.viewController = HomeViewControllerMock()
            self.viewModel = HomeViewModel(viewController: self.viewController)
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
                let apiMock = SearchBooksApiMock()
                apiMock.searchBooksResult = .success(responseMock)
                self.viewModel.api = apiMock
                
                self.viewModel.loadData()
                
                expect(self.viewModel.cellModels.count).to(equal(2))
                expect(self.viewController.didReloadTableView).to(beTrue())
                expect(self.viewController.didStopPullToRefresh).to(beTrue())
            }
            
            it("should do nothing when data load fails") {
                let responseMock = ApiError(message: "this is a error message.")
                let apiMock = SearchBooksApiMock()
                apiMock.searchBooksResult = .failure(responseMock)
                self.viewModel.api = apiMock
                
                self.viewModel.loadData()
                
                expect(self.viewModel.cellModels).to(beEmpty())
                expect(self.viewController.didShowAlert).to(beTrue())
            }
        }
    }
}
