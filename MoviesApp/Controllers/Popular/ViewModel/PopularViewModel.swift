//  PopularViewModel.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import UIKit

protocol PopularViewModelDelegate: AnyObject {
    
    /** Used to download all image from api asyncronously
     in order to not freeze ui */
    func downloadAllImages()
    /** Used to reload and update */
    func reloadTableData()
}

class PopularViewModel {
    
    var movies = [Movie]()
    private var cachedImages = [String:Data]()
    
    /** Delegate of PopularViewModel, which will notify
     changes to its conformed viewcontroller's functions */
    weak var delegate: PopularViewModelDelegate?
    
    init() {
        getPopularMovies() { (movies) in
            self.movies = movies
            PopularViewController.shared.moviesTableView.reloadData()
            PopularViewController.shared.downloadAllImages()
            self.delegate?.downloadAllImages()
            self.delegate?.reloadTableData()
        }
    }
    
    /** Get list of popular movies and assign response to movies. In this
     case we are only getting 20 movies, which are contents of 1 page*/
    func getPopularMovies(completion: @escaping ([Movie]) -> Void) {
        ApiManagerPopular.getPopular { (popularList) in
            completion(popularList.movies)
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
