//
//  API.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

extension Constant {
    
    class MOVIEAPI {
        
        private init() { }
        static let baseURL = "https://api.themoviedb.org/3/movie"
        static let popular = "/popular"
        static let topRated = "/top_rated"
        static let upcoming = "/upcoming"
        static let credits = "/credits"
        
    }
    
    class TVAPI {
        
        private init() { }
        static let baseURL = "https://api.themoviedb.org/3/tv"
        static let popular = "/popular"
        static let topRated = "/top_rated"
        static let onTheAir = "/on_the_air"
    }
    
    class MOVIECAST {
        
        static let baseURL = "https://api.themoviedb.org/3/movie"
        static let credits = "/credits"
        //https://api.themoviedb.org/3/movie/663712/credits?api_key=87fd921402216fc7603c5c63d278f30c&language=en-US
    }
    
    class TVCAST {
        
        static let baseURL = "https://api.themoviedb.org/3/tv"
        static let credits = "/credits"
        //https://api.themoviedb.org/3/tv/94997/credits?api_key=87fd921402216fc7603c5c63d278f30c&language=en-US
    }
}

