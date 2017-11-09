//
//  ServerManager.swift
//  MyMovies
//
//  Created by KANAKARAJU GANDREDDI on 11/7/17.
//  Copyright © 2017 RelianceJio. All rights reserved.
//
let APIKey = "77539e15e338e62729bfcfea44494aa8"
let APIURLPrefix = "https://api.themoviedb.org/3"
let imageURLPrefix = "https://image.tmdb.org/t/p"


import UIKit
import Alamofire
class ServerManager: NSObject {

    typealias completionHandlerWithData = (NSDictionary) -> Void

    
    //https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=77539e15e338e62729bfcfea44494aa8&page=2
    class func getMovieDataDB(urlString: String,completionHandler: @escaping completionHandlerWithData) -> Void {
        let parameters: [String: String] = ["api_key":"77539e15e338e62729bfcfea44494aa8","sort_by":"popularity.desc"]

        let requestUrl = "\(APIURLPrefix)/discover/movie?"

        Alamofire.request(requestUrl, method:.get, parameters: parameters, encoding:URLEncoding(destination: .queryString) , headers: nil).responseJSON { (response) in
            
            if let status = response.response?.statusCode {
                switch(status){
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            //to get JSON return value
            if let result = response.result.value {
                let JSON = result as! NSDictionary
               // print(JSON)
                
                completionHandler(result as! NSDictionary)
            }
        };
        
    }
}


