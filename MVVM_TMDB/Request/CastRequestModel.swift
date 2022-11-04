//
//  CastRequestModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import Foundation

final class CastRequestModel: RequestModel {
    
    private let moviePath: String
    private let movieID: Int
    
    init(moviePath: String, movieID: Int) {
        self.moviePath = moviePath
        self.movieID = movieID
    }
    override var movieId: Int? {
        movieID
    }
    override var baseURL: String {
        Constant.MOVIECAST.baseURL
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
        ]
    }
    
    
}
