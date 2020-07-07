//
//  ContentView.swift
//  SwiftUIMVVM
//
//  Created by Pedro Lopes on 06/07/20.
//  Copyright © 2020 Pedro Lopes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // 1
    @ObservedObject var viewModel = MovieViewModel()
    
    var body: some View {
        List(viewModel.movies) { movie in // 2
            HStack {
                VStack(alignment: .leading) {
                    Text(movie.title) // 3a
                        .font(.headline)
                    Text(movie.originalTitle) // 3b
                        .font(.subheadline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 1. We add the @ObservedObject property wrapper, to let our app know, what we need to observe for any changes in the viewModel property.
 2. We give our List the array of movies that we are going to fetch together with Combine. This will later be the part that automatically updates the list, when the data is added to the movies-array.
 3. a+b: We add the movie’s title and its original title to a Text-object.
 */
