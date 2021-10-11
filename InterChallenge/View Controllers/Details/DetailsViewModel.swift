//
//  DetailsViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Alamofire
import Foundation
import UIKit

class DetailsViewModel {
    
    var photoUrl = Observable<String>(value: "")
    var photo = Observable<UIImage>(value: UIImage())
    var name = Observable<String>(value: "")
    
    init(with photo: UIImage, by name: String) {
        self.photo.value = photo
        //self.photoUrl.value = userName
        self.name.value = name
    }
}
