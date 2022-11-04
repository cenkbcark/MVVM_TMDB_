//
//  TopRatedMovieResponseModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

// MARK: - TopRatedMovieModel
struct TopRatedMovieModel: Codable {
    let page: Int
    let results: [TopRatedResultMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TopRatedResultMovie: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path, release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path = "backdrop_path"
        case genre_ids = "genre_ids"
        case id
        case original_language = "original_language"
        case original_title = "original_title"
        case overview, popularity
        case poster_path = "poster_path"
        case release_date = "release_date"
        case title, video
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }
}

