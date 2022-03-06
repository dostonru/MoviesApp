//  Actor.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22.

struct Actor: Decodable {
    let id: Int
    let name: String?
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
