//
//  TitleAndDescriptionModelProtocol.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Foundation

protocol TitleAndDescription {
    var id: Int { get }
    var title: String { get }
    var body: String { get }
}