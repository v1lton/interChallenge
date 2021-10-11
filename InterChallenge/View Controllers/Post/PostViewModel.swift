//
//  PostViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Alamofire
import Foundation

class PostViewModel {
    
    var userId = Observable<Int>(value: 0)
    var userName = Observable<String>(value: "")
    var postViewModels = Observable<[TitleAndDescriptionCellViewModel]>(value: [])
    
    init(with userId: Int, by userName: String) {
        self.userId.value = userId
        self.userName.value = userName
        self.fillPosts(from: userId)
    }
    
    private func fillPosts(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/posts?userId=\(userId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Post].self, from: data)
                    self.postViewModels.value = models.map({return TitleAndDescriptionCellViewModel(model:$0)})
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}
