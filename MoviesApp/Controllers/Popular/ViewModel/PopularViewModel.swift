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
    weak var loadingDelegate: LoadingDelegate?
    
    /** Delegate of PopularViewModel, which will notify
     changes to its conformed viewcontroller's functions */
    weak var delegate: PopularViewModelDelegate?
    
    init() {
        getPopularMovies() { (movies) in
            self.movies = movies
            PopularViewController.shared.moviesTableView.reloadData()
            //PopularViewController.shared.downloadAllImages()
            
            self.loadingDelegate?.loadingIcon.stopAnimating()
            //self.delegate?.downloadAllImages()
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





/**
/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg
/bVL7LGq528h3KzeNI90HOVbV5uW.jpg
/lR5ilnIzIonItxL5mQPAPzXpwPJ.jpg
/pwDvkDyaHEU9V7cApQhbcSJMG1w.jpg
/f4aul3FyD3jv3v4bul1IrkWZvzq.jpg
/sqLowacltbZLoCa4KYye64RvvdQ.jpg
/4q2NNj4S5dG2RLF9CpXsej7yXl.jpg
/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg
/aXXkTxJbZJ8R9I3N47ekFiLkM1W.jpg
/6SyQ9ebUm90yPrIfQtIKvrFwxnj.jpg
/9kg73Mg8WJKlB9Y2SAJzeDKAnuB.jpg
/30YacPAcxpNemhhwX0PVUl9pVA3.jpg
/wf7SV7nSgxjSB9nCcCZGkwWTAdd.jpg
/loeeZwa4eD2kAz7Uau5AxDNm7pc.jpg
/hhXJpBZhmtT1vsuxti5H7O3uZuy.jpg
/k0DLCiDbnYywOHiISALbl2EH2NE.jpg
/gA6AD91r92cHFBrrny8e2xH17EJ.jpg
/ik3ebv7J18fs6cHkmu91oxz7EGt.jpg
/fMotwVtyUr833goyv7EzgAp0bCR.jpg
/eqTjO8yTaPRSKWj7i6Qnr7R5cls.jpg
/gLZEULfcS3uhfWDSEclOUgWiN41.jpg
/sZ6WoTwv7nXux9KvYJCcOKZjcUA.jpg
/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg
/or06FN3Dka5tukK1e9sl16pB3iy.jpg
/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg
/uoplwswBDy7gsOyrbGuKyPFoPCs.jpg
/rAGiXaUfPzY7CDEyNKUofk3Kw2e.jpg
/bGRC2gZZe3DJhaoY0qo3cHfS0pt.jpg
/8qlFNCxQQOLfnqwRcHY6WMkb7tF.jpg
/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg
 */
