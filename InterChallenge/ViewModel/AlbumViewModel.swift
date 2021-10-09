//
//  AlbumViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 08/10/21.
//

import Foundation

class AlbumViewModel {
    let id: Int
    let title: String
    
    init(album: Album) {
        self.id = album.id
        self.title = album.title
    }
}
