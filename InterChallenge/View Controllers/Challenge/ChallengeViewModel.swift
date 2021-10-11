//
//  ChallengeViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Alamofire
import Foundation

class ChallengeViewModel {
    //var userViewModels = [UserCellViewModel]()
    var userViewModels = Observable<[UserCellViewModel]>(value: [])
    
    init() {
        self.fillUsers()
    }
    
    private func fillUsers() {
        //Talvez aqui vá um [weak self]
        AF.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
            guard response.error == nil else {
//                let alert = UIAlertController(title: "Erro", message: "Algo errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//                    alert.dismiss(animated: true)
//                }))
//                self.present(alert, animated: true)
                return
            }
            
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([User].self, from: data)
                    self.userViewModels.value = models.map({return UserCellViewModel(user: $0)})
                    //self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}
