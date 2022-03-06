//
//  MovieViewModel.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 05/03/22.
//

import Foundation
import UIKit

protocol MovieViewModelDelegate: AnyObject {
    
    /** Used to download all images asyncronously*/
    func downloadAllImages()
    /** Used to reload table cell data to update its contents*/
    func refreshView()
    
}

class MovieViewModel {
    
    var castList: Cast!
    var selectedMovie : Movie?
    
    weak var delegate: MovieViewModelDelegate?
    
    private var cachedImages = [String:Data]()
    
    
    init(id: Int) {
        getMovie(with: id)
        getCast(with: id)
    }
    
    /** Get the movie details with selected unique id */
    func getMovie(with id: Int) {
        ApiManager.getMovie(with: id) { (movie) in
            self.selectedMovie = movie
        }
    }

    /** Get the actor details with selected unique id */
    func getCast(with id: Int) {
        castList = Cast(cast: [])
        ApiManager.getCast(with: id) { (cast) in
            self.castList = cast
            self.delegate?.refreshView()
            self.delegate?.downloadAllImages()
            
            MovieViewController.shared.refreshView()
            MovieViewController.shared.castCollectionView.reloadData()
            MovieViewController.shared.downloadAllImages()
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
