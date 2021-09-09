//
//  MovieInfoModel.swift
//  MovieApp
//
//  Created by APPLE on 07/09/21.
//

import Foundation
import SwiftyJSON

struct MovieModelData {
    var page: Int
    var result: [Movie]
    var total_results: Int
    var total_pages: Int
    
    init(data: JSON) {
        self.page = data["page"].intValue
        self.result = data["results"].arrayValue.map{ (Movie(data: $0)) }
        self.total_results = data["total_results"].intValue
        self.total_pages = data["total_pages"].intValue
    }
}

struct Movie {
    var title: String?
    var year: String?
    var rate: Double?
    var image: String?
    var overview: String?
    var id: Int?
    
    init(data: JSON) {
        self.title = data["title"].stringValue
        self.year = data["year"].stringValue
        self.rate = data["rate"].doubleValue
        self.image = data["poster_path"].stringValue
        self.overview = data["overview"].stringValue
        self.id = data["id"].intValue
    }
}

struct GenresModel {
    var id: Int?
    var name: String?
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.name = data["name"].stringValue
    }
}

struct SpokenLanguagesModel {
    var english_name: String?
    var iso_639_1: String?
    var name: String?
    
    init(data: JSON) {
        self.english_name = data["english_name"].stringValue
        self.iso_639_1 = data["iso_639_1"].stringValue
        self.name = data["name"].stringValue
    }
}

struct ProductionCompaniesModel {
    var id: Int?
    var logoPath: String?
    var name: String?
    var originCountry: String?
    
    init(data: JSON) {
        self.id = data["id"].intValue
        self.logoPath = data["logo_path"].stringValue
        self.name = data["name"].stringValue
        self.originCountry = data["origin_country"].stringValue
    }
}

struct ProductionCountriesModel {
    var iso_3166_1: String?
    var name: String?
    
    init(data: JSON) {
        self.iso_3166_1 = data["iso_3166_1"].stringValue
        self.name = data["name"].stringValue
    }
}

struct MovieDetailModel {
    var adult: Bool?
    var backdrop_path: String?
    var budget: String?
    var genres: [GenresModel]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [ProductionCompaniesModel]?
    var production_countries: [ProductionCountriesModel]?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [SpokenLanguagesModel]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    
    init(data: JSON) {
        self.adult = data["adult"].boolValue
        self.backdrop_path = data["backdrop_path"].stringValue
        self.budget = data["budget"].stringValue
        self.genres = data["genres"].arrayValue.map{ (GenresModel(data: $0)) }
        self.homepage = data["homepage"].stringValue
        self.id = data["id"].intValue
        self.imdb_id = data["imdb_id"].stringValue
        self.original_language = data["original_language"].stringValue
        self.original_title = data["original_title"].stringValue
        self.overview = data["overview"].stringValue
        self.popularity = data["popularity"].doubleValue
        self.poster_path = data["poster_path"].stringValue
        self.production_companies = data["production_companies"].arrayValue.map{ (ProductionCompaniesModel(data: $0)) }
        self.production_countries = data["production_countries"].arrayValue.map{ (ProductionCountriesModel(data: $0)) }
        self.release_date = data["release_date"].stringValue
        self.tagline = data["tagline"].stringValue
        self.title = data["title"].stringValue
        self.video = data["video"].boolValue
        self.vote_average = data["vote_average"].doubleValue
        self.vote_count = data["vote_count"].intValue
        self.spoken_languages = data["spoken_languages"].arrayValue.map{ (SpokenLanguagesModel(data: $0)) }
    }
    
}

