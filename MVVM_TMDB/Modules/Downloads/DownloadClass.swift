//
//  DownloadClass.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 4.11.2022.
//

import Foundation

class DownloadList {
    static let shared = DownloadList()
    
    var downloadList: [UpComingResultMovie] = []
}
