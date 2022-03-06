//
//  ActorViewController.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 05/03/22.
//

import UIKit
import SnapKit

class ActorViewController: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var id: Int = 0
    var actorViewModel: ActorViewModel!

    var castCollectionView: UICollectionView!
    static var shared = ActorViewController()
    
    var actorBiography = UITextView()
    var actorName = UILabel()
    var popularity = UILabel()
    var birthday = UILabel()
    var birthPlace = UILabel()
    var castTitle = UILabel()
    
    override func viewDidLoad() {
        ActorViewController.shared = self
        actorViewModel = ActorViewModel(id: id)
        super.viewDidLoad()
    }
    
    
    override func setupViewComponents() {
        
        
        actorName.text = "Unknown"
        actorName.font = .systemFont(ofSize: 20, weight: .bold)
        actorName.textAlignment = .center
        actorName.numberOfLines = 2
        
        view.addSubview(actorName)
        actorName.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        
        actorBiography.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ullamcorper arcu quis semper tincidunt. Vivamus id commodo purus. Aliquam erat volutpat. Integer tincidunt, ante a tristique tincidunt, metus diam sagittis mi, at convallis augue mauris ut sem."
        actorBiography.textAlignment = .justified
        actorBiography.font = .systemFont(ofSize: 14, weight: .regular)
        actorBiography.isEditable = false
        
        view.addSubview(actorBiography)
        actorBiography.snp.makeConstraints {
            $0.top.equalTo(actorName.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.height.lessThanOrEqualTo(200)
        }
        
        
        popularity.text = "Popularity: 10.342"
        popularity.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(popularity)
        popularity.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(actorBiography.snp.bottom).offset(10)
        }
        
        
        birthPlace.text = "Birth place: Uzbekistan"
        birthPlace.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(birthPlace)
        birthPlace.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(popularity.snp.bottom).offset(5)
        }
        
        birthday.text = "Birthday: 5 March 2022"
        birthday.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(birthday)
        birthday.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(birthPlace.snp.bottom).offset(5)
        }
        
       
        castTitle.text = "Movies"
        castTitle.font = .systemFont(ofSize: 20, weight: .bold)
        castTitle.textAlignment = .center
        
        view.addSubview(castTitle)
        castTitle.snp.makeConstraints {
            $0.centerY.equalTo(birthday.snp.bottom).offset(40)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        let castCollectionLayout = UICollectionViewFlowLayout()
        castCollectionLayout.scrollDirection = .horizontal
        
        castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: castCollectionLayout)
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.showsHorizontalScrollIndicator = false
        castCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cell)
        
        view.addSubview(castCollectionView)
        castCollectionView.snp.makeConstraints {
            $0.top.equalTo(castTitle.snp.bottom).offset(10)
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
    
    /** Refreshing all ui elements after  downloading movie and actor details from api*/
    func refreshView() {
        castCollectionView.reloadData()
        actorName.text = actorViewModel.selectedActor?.name
        actorBiography.text = actorViewModel.selectedActor?.biography
        popularity.text = "Popularity: \(actorViewModel.selectedActor?.popularity ?? 0)"
        birthPlace.text = "Born place: \(actorViewModel.selectedActor?.bornPlace ?? "Unknown")"
        birthday.text = "Birthday: " + (actorViewModel.selectedActor?.birthday ?? "Unknown")
    }
    
    func downloadAllImages() {
        for image in actorViewModel.movies {
            if let picture = image.image {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.actorViewModel.getImage(from: picture) { _ in }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorViewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cell, for: indexPath) as! MovieCollectionViewCell
        
        cell.setupWithAttributes(with: actorViewModel.movies[indexPath.row].title)
        
        if let pictureUrl = actorViewModel.movies[indexPath.row].image {
            actorViewModel.getImage(from: pictureUrl) { (image) in
                cell.pictureView.image = image
            }
        } else {
            cell.pictureView.image = UIImage(named: "default-picture")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieController = MovieViewController()
        movieController.id = actorViewModel.movies[indexPath.row].id
        present(movieController, animated: true, completion: nil)
    }
}
