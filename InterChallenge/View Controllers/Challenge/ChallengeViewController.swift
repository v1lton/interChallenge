import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    
    private var userViewModels = [UserCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Desafio"
        self.tableView.estimatedRowHeight = 233
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        fillUsers()
    }
    
    // MARK: Table View Configuration
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let userViewModel = userViewModels[indexPath.row]
        cell.userViewModel = userViewModel
        cell.bind(delegate: self, row: indexPath.row)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AlbumTableViewController {
            if let info = sender as? (id: Int, name: String) {
                destinationVC.userId = info.id
                destinationVC.userName = info.name
            }
        }
        
        if let destinationVC = segue.destination as? PostTableViewController {
            if let info = sender as? (id: Int, name: String) {
                destinationVC.userId = info.id
                destinationVC.userName = info.name
            }
        }
    }
    
    // MARK: - Service
    
    // Chamada de API para pegar os usuários
    private func fillUsers() {
        //Talvez aqui vá um [weak self]
        AF.request("https://jsonplaceholder.typicode.com/users").validate().responseJSON { response in
            guard response.error == nil else {
                let alert = UIAlertController(title: "Erro", message: "Algo errado aconteceu. Tente novamente mais tarde.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
                return
            }
            
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([User].self, from: data)
                    self.userViewModels = models.map({return UserCellViewModel(user: $0)})
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}

extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with userId: Int, by name: String) {
        let albumTableViewController = AlbumTableViewController()
        albumTableViewController.setUser(id: userId, name: name)
        self.navigationController?.pushViewController(albumTableViewController, animated: true)
    }
    
    func didTapPosts(with userId: Int, by name: String) {
        let postTableViewController = PostTableViewController()
        postTableViewController.setUser(id: userId, name: name)
        self.navigationController?.pushViewController(postTableViewController, animated: true)
    }
}
