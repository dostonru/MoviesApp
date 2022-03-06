//  Popular.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

struct Result: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
