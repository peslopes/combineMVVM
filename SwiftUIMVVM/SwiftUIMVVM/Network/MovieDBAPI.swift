//
//  MovieDBAPI.swift
//  SwiftUIMVVM
//
//  Created by Pedro Lopes on 06/07/20.
//  Copyright © 2020 Pedro Lopes. All rights reserved.
//

import Foundation
import Combine

// 1
enum MovieDB {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
    static let apiKey = "ad28148852ee2cbbb8766d7babbf7c5e"
}

// 2
enum APIPath: String {
    case trendingMoviesWeekly = "trending/movie/week"
    case coverPath = "https://image.tmdb.org/t/p/w500"
}

extension MovieDB {
    
    static func request(_ path: APIPath) -> AnyPublisher<MovieResponse, Error> {
        // 3
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)] // 4
        
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request) // 5
            .map(\.value) // 6
            .eraseToAnyPublisher() // 7
    }
    
}

/*
     1. Set up the basics needed for making the request
     2. Set up the paths we want to be able to call from the API.
     3. Here we create the URL request. The request is a GET-request by default, hence we don’t need to specify that.
     4. Add the api_key you created at The Movie Database here!
     5. We run the newly created request through our API client
     6. Map is our operator, that lets us set the type of output we want. \.value in this case, is our generic type defined as return value of this method (MoviesData), since the client returns a Response-object, which contains both a value and a response property, but for now, we’re only interested in the value.
     7. This call cleans up the return type from something like Publishers.MapKeyPath<AnyPublisher<APIClient.Response<MoviesData>, Error>, T> to the expected type: AnyPublisher<MoviesData, Error>
 */
