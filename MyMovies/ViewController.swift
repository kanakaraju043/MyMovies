//
//  ViewController.swift
//  MyMovies
//
//  Created by KANAKARAJU GANDREDDI on 11/7/17.
//  Copyright © 2017 RelianceJio. All rights reserved.
//

import UIKit
let imageURLPrefixSmall = "https://image.tmdb.org/t/p/w185"
import Kingfisher
class ViewController: UIViewController,UICollectionViewDataSource{
    var yourArray = [MovieManager]()
    let columns: CGFloat = 2.0
    let lineSpace: CGFloat = 8.0
    let inset: CGFloat = 8.0
    let space: CGFloat = 8.0
    var selectedSegment = "popular"
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var prevBtn: UIButton!
    
    var currentPage:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        prevBtn.isEnabled = false
        self.title = "My Movies"
        
        MovieManager.loadMovieDataWithType(type: "popular") { (moviedata) in
           // print(moviedata)
            
            DispatchQueue.main.async {
                self.yourArray = moviedata

                self.movieCollectionView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            NSLog("Popular selected")
            self.selectedSegment = "popular"
            MovieManager.loadMovieDataWithType(type: "popular") { (moviedata) in
                
                DispatchQueue.main.async {
                    self.yourArray = moviedata
                    
                    self.movieCollectionView.reloadData()
                }
            }
        case 1:
            NSLog("TopRated selected")
            self.selectedSegment = "Toprated"

            MovieManager.loadMovieDataWithType(type: "TopRated") { (moviedata) in
                
                DispatchQueue.main.async {
                    self.yourArray = moviedata
                    
                    self.movieCollectionView.reloadData()
                }
            }
        default:
            break;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            
            let destinationController  = segue.destination as! MovieDetailViewController
            destinationController.movieData = sender as? MovieManager
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.yourArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        // Configuring Cell
        let dataItem = yourArray[indexPath.item]
        let urlRequest = "\(imageURLPrefixSmall)\(dataItem.posterPath)"
        cell.movieTitleLabel.text = dataItem.title
        
        let url:URL = URL.init(string: urlRequest)!
        let r = ImageResource(downloadURL: url, cacheKey: nil)
        cell.posterImageView.image = nil
        
        cell.posterImageView.kf.setImage(with: r, placeholder: nil)
        
        cell.posterImageView.kf.setImage(with: r)
        return cell
    }
    
    @IBAction func previousBtnAction(_ sender: Any) {
        
        
        
        self.currentPage = self.currentPage-1
        
        if self.currentPage>1{
            prevBtn.isEnabled = true
        }else{
            
            prevBtn.isEnabled = false
        }
        
        MovieManager.loadMoreMovieDataWithTypeAndPage(type: self.selectedSegment, currentPage: self.currentPage) { (movies) in
            DispatchQueue.main.async {
                self.yourArray = movies
                
                self.movieCollectionView.reloadData()
            }
        }
        
       
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        if self.currentPage>=1{
            prevBtn.isEnabled = true
        }else{
            
            prevBtn.isEnabled = false
        }
        self.currentPage = self.currentPage+1
        

        MovieManager.loadMoreMovieDataWithTypeAndPage(type: self.selectedSegment, currentPage: self.currentPage) { (movies) in
            DispatchQueue.main.async {
                self.yourArray = movies
                
                self.movieCollectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = yourArray[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: data)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = Int((collectionView.frame.width/columns) - (inset+space))
        return CGSize(width: width ,height: width)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: inset , left: inset ,bottom: inset , right: inset)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return lineSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return space
    }
    
    
}


