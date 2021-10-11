//
//  Coordinator.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
