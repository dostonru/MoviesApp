//  Popular.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import Foundation

struct Result: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let id : Int
    let title : String
    let description: String?
    let rating: Double?
    let date: String
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

struct Genre: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct Cast: Decodable {
    let cast: [Actor]
    
    enum CodingKeys: String, CodingKey {
        case cast
    }
}

struct ActorCast: Decodable {
    let cast: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case cast
    }
}

struct Actor: Decodable {
    let id: Int
    let name: String
    let popularity: Double?
    let character: String?
    let biography: String?
    let picture: String?
    let bornPlace: String?
    let birthday: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case popularity
        case character
        case biography
        case picture = "profile_path"
        case bornPlace = "place_of_birth"
        case birthday
    }
}
