//
//  MovieCatalog.swift
//  SwiftUIMVVM
//
//  Created by Pedro Lopes on 06/07/20.
//  Copyright © 2020 Pedro Lopes. All rights reserved.
//

import Foundation

struct Movie: Codable, Identifiable {
    var id = UUID()
    let movieId: Int
    let originalTitle: String
    let title: String
    let poster_path: String

    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case originalTitle = "original_title"
        case title
        case poster_path
    }
}
