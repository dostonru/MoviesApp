//  TopRatedViewModel.swift
//  MoviesApp
//  Created by Doston Rustamov on 06/03/22.

import Foundation
import UIKit

protocol TopRatedViewModelDelegate: AnyObject {
    
    /** Used to download all image from api asyncronously
     in order to not freeze ui */
    func downloadAllImages()
    /** Used to reload and update */
    func reloadTableData()
}

class TopRatedViewModel {
    
    var movies = [Movie]()
    private var cachedImages = [String:Data]()
    
    /** Delegate of TopRatedViewModel, which will notify
     changes to its conformed viewcontroller's functions */
    weak var delegate: TopRatedViewModelDelegate?
    
    /** Delegate of the loading protocol which will be
     controll loading icon to the parent view controller*/
    weak var loadingDelegate: LoadingDelegate?
    
    init() {
        getTopRatedMovies() { (movies) in
            self.movies = movies
            TopRatedViewController.shared.moviesTableView.reloadData()
            //TopRatedViewController.shared.downloadAllImages()
            self.loadingDelegate?.loadingIcon.stopAnimating()
           // self.delegate?.downloadAllImages()
            self.delegate?.reloadTableData()
        }
    }
    
    /** Get list of popular movies and assign response to movies. In this
     case we are only getting 20 movies, which are contents of 1 page*/
    func getTopRatedMovies(completion: @escaping ([Movie]) -> Void) {
        ApiManagerTopRated.getTopRated { (topRatedList) in
            completion(topRatedList.movies)
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
