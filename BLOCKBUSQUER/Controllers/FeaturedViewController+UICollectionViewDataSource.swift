//
//  FeaturedViewController+UICollectionViewDataSource.swift
//  BLOCKBUSQUER
//
//  Created by Ryan Araújo on 12/07/22.
//

import UIKit

extension FeaturedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.popularCollectionView {
            return popularMovies.count
        } else if collectionView == self.nowPlayingCollectionView {
            return nowPlayingMovies.count
        } else {
            return upcomingMovies.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularCollectionView {
            return makePopularCell(indexPath)
        } else if collectionView == self.nowPlayingCollectionView {
            return makeNowPlayingCell(indexPath)
        } else {
            return makeUpcomingCell(indexPath)
        }
        
    }
    
    fileprivate func makePopularCell(_ indexPath: IndexPath) -> PopularCollectionViewCell {
        if let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell {
            cell.setup(title: popularMovies [indexPath.item].title, image: UIImage())
            
            let movie = popularMovies[indexPath.item]
            Task {
                let imageData = await Movie.downloadImageData(withPath: movie.backdropPath)
                let image = UIImage(data: imageData) ?? UIImage()
                cell.setup(title: movie.title, image: image)
            }
            return cell
        }
        return PopularCollectionViewCell()
    }
    
    fileprivate func makeNowPlayingCell(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        if let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell {
            
            let year: String = "\(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))"
            
            let nowPlayingMovie = nowPlayingMovies[indexPath.item]
            
            cell.setup(title: nowPlayingMovie.title, year: year, image: UIImage())
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: nowPlayingMovie.posterPath)
                
                let year: String = "\(nowPlayingMovie.releaseDate.prefix(4))"
                
                let image = UIImage(data: imageData) ?? UIImage()
                cell.setup(title: nowPlayingMovie.title, year: year, image: image)
            }
            
            return cell
        }
        
        return NowPlayingCollectionViewCell()
    }
    
    fileprivate func makeUpcomingCell(_ indexPath: IndexPath) -> UpcomingCollectionViewCell {
        if let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.cellIdentifier, for: indexPath) as? UpcomingCollectionViewCell {
            
            let year: String = "\(upcomingMovies[indexPath.item].releaseDate.prefix(4))"
            
            let upcomingMovie = upcomingMovies[indexPath.item]
            
            cell.setup(image: UIImage(), title: upcomingMovie.title, date: upcomingMovie.releaseDate)
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: upcomingMovie.posterPath)
                
                let year: String = "\(upcomingMovie.releaseDate.prefix(4))"

                
                let image = UIImage(data: imageData) ?? UIImage()
                cell.setup(image: image, title: upcomingMovie.title, date: year)
            }
            
            return cell
        }
        
        return UpcomingCollectionViewCell()
    }
    
   
}
