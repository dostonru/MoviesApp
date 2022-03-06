//
//  ApiManagerPopular.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 05/03/22.
//

import Foundation
import Alamofire

class ApiManagerPopular {
    
    /** Get the list of the popular films */
    static func getPopular(completion: @escaping (Result) -> Void) {
        
        let url = BASE_URL + "/movie/popular"
        
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
