//
//  SearchBooksApi.swift
//  iOS-101-day5
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchBooksApiProtocol {
    func searchBooks(q: String, start: Int, count: Int, completion: @escaping (Result<SearchBooksApi.Response, ApiError>) -> Void)
}

class SearchBooksApi: SearchBooksApiProtocol {
    
    let url = "https://api.douban.com/v2/book/search"
    
    struct Response: Decodable {
        let total: Int
        let count: Int
        let books: [Book]
        
        struct Book: Decodable {
            let title: String
            let author: [String]
            let images: Images
            
            struct Images: Decodable {
                let small: URL
            }
        }
    }
    
    ///
    /// - Parameters:
    ///     - q: 查询关键词
    ///     - start: 从第几条开始
    ///     - count: 一页条数
    func searchBooks(q: String, start: Int, count: Int, completion: @escaping (Result<SearchBooksApi.Response, ApiError>) -> Void) {
        let parameters: Parameters = [
            "apikey": apiKey,
            "q": q,
            "start": start,
            "count": count
        ]
        AF.request(url, parameters: parameters).responseDecodable(of: SearchBooksApi.Response.self) { (response) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(ApiError(message: error.localizedDescription)))
            }
        }
    }
}

