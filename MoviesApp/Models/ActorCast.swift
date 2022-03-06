//  ActorCast.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22

struct ActorCast: Decodable {
    let cast: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case cast
    }
}
