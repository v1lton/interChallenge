//
//  CommentViewModel.swift
//  InterChallenge
//
//  Created by Wilton Ramos on 11/10/21.
//

import Alamofire
import Foundation

class CommentViewModel {
    var postId = Observable<Int>(value: 0)
    var userName = Observable<String>(value: "")
    var commentViewModels = Observable<[CommentCellViewModel]>(value: [])
    
    init(with postId: Int, by userName: String) {
        self.postId.value = postId
        self.userName.value = userName
        self.fillComments(from: postId)
    }
    
    private func fillComments(from postId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/comments?postId=\(postId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Comment].self, from: data)
                    self.commentViewModels.value = models.map({return CommentCellViewModel(comment:$0)})
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
   }
}
