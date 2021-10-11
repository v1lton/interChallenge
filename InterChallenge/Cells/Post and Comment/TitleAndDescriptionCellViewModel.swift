//
//  PostViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 08/10/21.
//

import Foundation

class TitleAndDescriptionViewModel {
    var id: Int = 0
    var title: String = ""
    var body: String = ""
}

class TitleAndDescriptionCellViewModel: TitleAndDescriptionViewModel {
    init(post: Post) {
        super.init()
        self.title = post.title
        self.body = post.body
        self.id = post.id
    }
}
