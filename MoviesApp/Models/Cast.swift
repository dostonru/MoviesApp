//  Cast.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22.

struct Cast: Decodable {
    let cast: [Actor]
    
    enum CodingKeys: String, CodingKey {
        case cast
    }
}

