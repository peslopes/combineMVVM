//
//  MovieListViewModel.swift
//  SwiftUIMVVM
//
//  Created by Pedro Lopes on 06/07/20.
//  Copyright © 2020 Pedro Lopes. All rights reserved.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    @Published var movies: [Movie] = [] // 1
    var cancellationToken: AnyCancellable? // 2
    
    init() {
        getMovies() // 3
    }
    
}

extension MovieViewModel {
    
    // Subscriber implementation
    func getMovies() {
        cancellationToken = MovieDB.request(.trendingMoviesWeekly) // 4
            .mapError({ (error) -> Error in // 5
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, // 6
                  receiveValue: {
                    self.movies = $0.movies // 7
            })
    }
    
}

/*
     1. The @Published property wrapper lets Swift know to keep an eye on any changes of this variable. If anything changes, the body in all views where this variable is used, will update.
     2. Subscriber implementations can use this type to provide a “cancellation token” that makes it possible for a caller to cancel a publisher. Be aware that your network calls won’t work if you’re not assigning your call to a variable of this type.
     3. We are fetching the data as soon as the ViewModel is created, since there’s no lifecycle in SwiftUI like we’re used to from UIKit.
     4. Here we start the actual request for “trending movies weekly”
     5. Here we can handle the errors, if any
     6. Here the actual subscriber is created. As mentioned earlier, the sink-subscriber comes with a closure, that lets us handle the received value when it’s ready from the publisher.
     7. We assign the received data to the movies-property - this will trigger the action mentioned in step 1
 */
