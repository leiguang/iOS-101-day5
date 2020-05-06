//
//  SearchBooksApiMock.swift
//  iOS-101-day5Tests
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

@testable import iOS_101_day5

class SearchBooksApiMock: SearchBooksApiProtocol {
    var didSearchBooks = false
    var searchBooksResult: Result<SearchBooksApi.Response, ApiError>?
    
    func searchBooks(q: String, start: Int, count: Int, completion: @escaping (Result<SearchBooksApi.Response, ApiError>) -> Void) {
        didSearchBooks = true
        if let result = searchBooksResult {
            completion(result)
        }
    }
}
