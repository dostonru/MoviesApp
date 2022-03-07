//
//  ActorViewModel.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 05/03/22.
//

import Foundation
import UIKit

// MARK: ACTOR VIEW MODEL
class ActorViewModel {
    
    var movies = [Movie]()
    var selectedActor: Actor?
    
    var cachedImages = [String: Data]()
    
    weak var loadingDelegate: LoadingDelegate?
    
    init(id: Int) {
        getActor(with: id)
        getActorMovies(with: id)
    }
    
    /** Getting movies that actor were casted*/
    func getActorMovies(with id: Int) {
        ApiManager.getActorMovies(with: id) { (movieList) in
            self.movies = movieList.cast
            self.loadingDelegate?.loadingIcon.stopAnimating()
            
            ActorViewController.shared.refreshView()
            ActorViewController.shared.downloadAllImages()
        }
    }
    
    
    /** Get the actor details with selected unique id */
    func getActor(with id: Int) {
        ApiManager.getActor(with: id) { (actorDetails) in
            self.selectedActor = actorDetails
        }
    }
    
    
    /** Cachind downloaded images into array to reuse
     them in the future casese*/
    func getImage(from url: String, completion: @escaping (UIImage) -> Void) {
       
        if let imageData = cachedImages[url] {
            completion(UIImage(data: imageData)!)
            return
        }
        
        let fullUrl = URL(string: IMAGE_URL + url)
        
        if let data = try? Data(contentsOf: fullUrl!) {
            cachedImages[url] = data
            completion(UIImage(data: data)!)
            return
        }
    }
}
