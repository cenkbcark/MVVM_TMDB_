//
//  MovieRequestModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

final class MovieRequestModel: RequestModel {
    
    private let page: Int
    private let moviePath: String
    
    init(page: Int,moviePath:String) {
        self.page = page
        self.moviePath = moviePath
    }
    
    override var baseURL: String {
        Constant.MOVIEAPI.baseURL
    }
    
    override var path: String {
        moviePath
    }
    
    override var method: RequestMethod {
        .get
    }
    
    override var parameters: [String : Any?] {
        [
            "api_key": "594b8eb4999a8b44ad5136ee3ed1ebdb",
            "page": String(self.page)
        ]
    }
}
