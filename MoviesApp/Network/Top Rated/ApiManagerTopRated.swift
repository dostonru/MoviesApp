//  ApiManagerTopRated.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22

import Alamofire

class ApiManagerTopRated {
    
    /** Get the list of the popular films */
    static func getTopRated(completion: @escaping (Result) -> Void) {
        
        let url = BASE_URL + "/movie/top_rated"
        
        let headers : HTTPHeaders = [
            .authorization(bearerToken: API_KEY)
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: Result.self) { (response) in
                guard let popularList = response.value else { return }
                completion(popularList)
            }
    }
    
}
