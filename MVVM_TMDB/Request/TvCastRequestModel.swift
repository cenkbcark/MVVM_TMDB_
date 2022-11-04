//
//  TvCastRequestModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 4.11.2022.
//

import Foundation

final class CastTvRequestModel: RequestModel {
    
    private let tvPath: String
    private let tvID: Int
    
    init(tvPath: String, tvID: Int) {
        self.tvID = tvID
        self.tvPath = tvPath
    }
    
    override var movieId: Int? {
        tvID
    }
    
    override var baseURL: String {
        Constant.TVCAST.baseURL
    }
    
    override var path: String {
        tvPath
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
