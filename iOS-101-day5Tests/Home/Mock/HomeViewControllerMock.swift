//
//  HomeViewControllerMock.swift
//  iOS-101-day5Tests
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import Foundation
@testable import iOS_101_day5

class HomeViewControllerMock: HomeViewControllerProtocol {
    var didReloadTableView = false
    var didStopPullToRefresh = false
    var didShowAlert = false
    
    func reloadTableView() {
        didReloadTableView = true
    }
    
    func stopPullToRefresh() {
        didStopPullToRefresh = true
    }
    
    func showAlert(message: String) {
        didShowAlert = true
    }
}
