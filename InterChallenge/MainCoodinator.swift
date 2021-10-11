//
//  MainCoodinator.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let challengeViewController = ChallengeViewController()
        challengeViewController.coordinator = self
        self.navigationController.pushViewController(challengeViewController, animated: true)
    }
    
    func showPosts(with userId: Int, by name: String) {
        let postTableViewController = PostTableViewController(viewModel: PostViewModel(with: userId, by: name))
        postTableViewController.coordinator = self
        self.navigationController.pushViewController(postTableViewController, animated: true)
    }
    
    func showAlbums(with userId: Int, by name: String) {
        let albumTableViewController = AlbumTableViewController(viewModel: AlbumViewModel(with: userId, by: name))
        albumTableViewController.coordinator = self
        self.navigationController.pushViewController(albumTableViewController, animated: true)
    }
    
    func showComments(with postId: Int, by userName: String) {
        let commentTableViewController = CommentTableViewController(viewModel: CommentViewModel(with: postId, by: userName))
        commentTableViewController.coordinator = self
        self.navigationController.pushViewController(commentTableViewController, animated: true)

    }
    
    func showPhotos(with albumId: Int, by userName: String) {
        let photoTableViewController = PhotoTableViewController(viewModel: PhotoViewModel(with: albumId, by: userName))
        photoTableViewController.coordinator = self
        self.navigationController.pushViewController(photoTableViewController, animated: true)
    }
    
    func showDetails(with photoUrl: String, by description: String) {
        let detailsViewController = DetailsViewController(viewModel: DetailsViewModel(with: photoUrl, by: description))
        detailsViewController.coordinator = self
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
}
