//
//  MoviesService.swift
//  Flixter
//
//  Created by Akash Aggarwal on 2/27/22.
//

import Foundation

class MoviesService {
    
    static let shared = MoviesService()
    
    func fetchMovies(completion: @escaping(([Movies]) -> Void)) {
        print("in fetch")
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print("in error")
                    print(error.localizedDescription)
             } else if let data = data {
                 
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let moviesRawData = dataDictionary["results"] as! [[String:Any]]
                 print("in fetch data")
                 //print(moviesRawData)
                 var movies = [Movies]()
                 
                 for rawData in moviesRawData {
                     let baseUrl = "https://image.tmdb.org/t/p/w185"
                     let posterPath = rawData["poster_path"] as! String
                     let posterURL = baseUrl+posterPath
                     //let posterURL = URL(string: baseUrl+posterPath)
                     let movie = Movies(name: rawData["title"] as! String,
                                        description: rawData["overview"] as! String,
                                        imageURL: posterURL)
                     
                     movies.append(movie)
                 }
                                    
                completion(movies)
             }
        }
        task.resume()

        
    }
   
}
