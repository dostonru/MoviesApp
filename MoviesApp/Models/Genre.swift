//  Genre.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22.

import Foundation

struct Genre: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
