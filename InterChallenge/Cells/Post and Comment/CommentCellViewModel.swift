//
//  CommentViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 08/10/21.
//

import Foundation

class CommentCellViewModel: TitleAndDescriptionViewModel {
    
    init(comment: Comment) {
        super.init()
        self.id = comment.id
        self.title = comment.name
        self.body = comment.body
    }
}
