//
//  MovieManager.swift
//  MyMovies
//
//  Created by KANAKARAJU GANDREDDI on 11/7/17.
//  Copyright © 2017 RelianceJio. All rights reserved.
//


import Foundation
import Alamofire

enum Type: Int {
    case Popular = 1
    case TopRated = 2
    case Search = 3
}
let APIKey1 = "77539e15e338e62729bfcfea44494aa8"
let APIURLPrefix1 = "https://api.themoviedb.org/3"

class MovieManager {
    typealias completionHandlerWithData = ([MovieManager]) -> Void

    var  voteCount: Int
    var  id: Int
    var  video: Bool
    var  voteAverage: Float
    var  title: String
    var  popularity: Double
    var  posterPath: String
    var  originalLanguage: String
    var  originalTitle: String
    var  adult: Bool
    var  overView: String
    var  releaseDate: String
    
    init(voteCount: Int, id: Int, video: Bool, voteAverage: Float, title: String, popularity: Double, posterPath: String, originalLanugage: String, originalTitle: String, adult: Bool, overview: String, releaseDate: String) {
        
        self.voteCount = voteCount
        self.id = id
        self.video = video
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.originalLanguage = originalLanugage
        self.originalTitle = originalTitle
        self.adult = adult
        self.overView = overview
        self.releaseDate = releaseDate
        
    }
    
    convenience init(dictionary: NSDictionary) {
       
        let voteCount = dictionary["vote_count"] as? Int
        let id = dictionary["id"] as? Int
        let video = dictionary["video"] as? Bool
        let voteAverage = dictionary["vote_average"] as? Float
        let tilte = dictionary["title"] as? String
        let popularity = dictionary["popularity"] as? Double
        let posterPath = dictionary["poster_path"] as? String
        let originalLanguage = dictionary["original_language"] as? String
        let originalTitle = dictionary["original_title"] as? String
        let adult = dictionary["adult"] as? Bool
        let overview = dictionary["overview"] as? String
        let releaseDate = dictionary["release_date"] as? String
        
        self.init(voteCount: voteCount!, id: id!, video: video!, voteAverage: voteAverage!, title: tilte!, popularity: popularity!, posterPath: posterPath!, originalLanugage: originalLanguage!, originalTitle: originalTitle!, adult: adult!, overview: overview!, releaseDate: releaseDate!)
    }
    
  class  func loadMovieDataWithType(type: String,completionHandler: @escaping completionHandlerWithData) -> Void {
        
        var movieData =  [MovieManager]()
        
        let parameters: [String: String]
        let requestUrl: String
    
    if type.elementsEqual("popular") {
      parameters  = ["api_key":"77539e15e338e62729bfcfea44494aa8","sort_by":"popularity.desc"]
        requestUrl = "\(APIURLPrefix)/discover/movie?"

    }else{
        parameters  = ["api_key":"77539e15e338e62729bfcfea44494aa8","sort_by":"vote_average.desc"]
        requestUrl = "\(APIURLPrefix)/discover/movie/?certification_country=US&certification=R"

        
    }
    
    
        Alamofire.request(requestUrl, method:.get, parameters: parameters, encoding:URLEncoding(destination: .queryString) , headers: nil).responseJSON { (response) in
           
            if let result = response.result.value {
                let JSON = result as! NSDictionary
               //  print(JSON)
                let jsonArray = JSON["results"] as! NSArray
                for item in jsonArray {
                    
                    let dataDict = MovieManager(dictionary: item as! NSDictionary)
                    movieData.append(dataDict)
                }
            }
           
            completionHandler(movieData)
        };
        
        
    }
    
    
    class  func loadMoreMovieDataWithTypeAndPage(type: String,currentPage:Int,completionHandler: @escaping completionHandlerWithData) -> Void {
        
        var movieData =  [MovieManager]()
        
        let parameters: [String: String]
        let requestUrl: String
        
        if type.elementsEqual("popular") {
            parameters  = ["api_key":"77539e15e338e62729bfcfea44494aa8","sort_by":"popularity.desc"]
            requestUrl = "\(APIURLPrefix)/discover/movie?&page=\(currentPage)"
            
        }else{
            parameters  = ["api_key":"77539e15e338e62729bfcfea44494aa8","sort_by":"vote_average.desc"]
            requestUrl = "\(APIURLPrefix)/discover/movie/?certification_country=US&certification=R&page=\(currentPage)"
            
            
        }
        
        Alamofire.request(requestUrl, method:.get, parameters: parameters, encoding:URLEncoding(destination: .queryString) , headers: nil).responseJSON { (response) in
            
            if let result = response.result.value {
                let JSON = result as! NSDictionary
                //  print(JSON)
                let jsonArray = JSON["results"] as! NSArray
                for item in jsonArray {
                    
                    let dataDict = MovieManager(dictionary: item as! NSDictionary)
                    movieData.append(dataDict)
                }
            }
            
            completionHandler(movieData)
        };
        
        
    }
}
