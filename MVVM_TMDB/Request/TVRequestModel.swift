//
//  TVRequestModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

final class TVRequestModel: RequestModel {
    
    private let page: Int
    private let tvPath: String
    
    init(page: Int,tvPath:String) {
        self.page = page
        self.tvPath = tvPath
    }
    
    override var baseURL: String {
        Constant.TVAPI.baseURL
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
            "page": String(self.page)
        ]
    }
}
