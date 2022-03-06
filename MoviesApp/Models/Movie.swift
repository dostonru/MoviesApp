//  Movie.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22.

struct Movie: Decodable {
    let id : Int
    let title : String?
    let description: String?
    let rating: Double?
    let date: String?
    let budget: Int?
    let genres: [Genre]?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case rating = "vote_average"
        case date = "release_date"
        case image = "poster_path"
        case budget
        case genres
        
    }
}
