//
//  ChallengeViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Alamofire
import Foundation

class ChallengeViewModel: TableViewCompatible {
    var reuseIdentifier: String {
        return "UserCell"
    }
    
    var userViewModels = Observable<[UserCellViewModel]>(value: [])
    var error = Observable<Bool>(value: false)
    
    init() {
        self.fillUsers()
    }
    
    private func fillUsers() {
        AF.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
            guard response.error == nil else {
                self.error.value = true
                return
            }
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([User].self, from: data)
                    self.userViewModels.value = models.map({return UserCellViewModel(user: $0)})
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}
