//
//  ApiManager.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 05/03/22.
//

import Foundation
import Alamofire

class ApiManager {

    /** Get movie details with given id */
    static func getMovie(with id: Int,completion: @escaping (Movie) -> Void) {
        
        let url = BASE_URL + "/movie/" + "\(id)"
        
        let headers : HTTPHeaders = [
            .authorization(bearerToken: API_KEY)
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Movie.self) { (response) in
                guard let movie = response.value else { return }
                completion(movie)
            }
    }
    
    
    /** Get actor details with given id */
    static func getActor(with id: Int,completion: @escaping (Actor) -> Void) {
        
        let url = BASE_URL + "/person/" + "\(id)"
        
        let headers : HTTPHeaders = [
            .authorization(bearerToken: API_KEY)
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Actor.self) { (response) in
                guard let actor = response.value else { return }
                completion(actor)
            }
    }
    
    
    /** Get movie cast details with given movie id */
    static func getCast(with id: Int, completion: @escaping (Cast) -> Void) {
        
        let url = BASE_URL + "/movie/" + "\(id)" + "/credits"
        
        let headers : HTTPHeaders = [
            .authorization(bearerToken: API_KEY)
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Cast.self) { (response) in
                guard let cast = response.value else { return }
                completion(cast)
            }
    }
    
    
    static func getActorMovies(with id: Int, completion: @escaping (ActorCast) -> Void) {
        let url = BASE_URL + "/person/" + "\(id)" + "/movie_credits"
        
        let headers : HTTPHeaders = [
            .authorization(bearerToken: API_KEY)
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: ActorCast.self) { (response) in
                guard let cast = response.value else { return }
                completion(cast)
            }
    }
}

