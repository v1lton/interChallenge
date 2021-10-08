import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    
    var users = [User]()
    private var userViewModels = [UserViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Desafio"
        self.tableView.rowHeight = 233
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        fillUsers()
    }
    
    // MARK: Table View Configuration
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(userViewModels.count)
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
                    self.userViewModels = models.map({return UserViewModel(user: $0)})
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}

// Protocolo da UserTableViewDelegate para especificar para onde ir
extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with userId: Int, by name: String) {
        let userIdAndName = (id: userId, name: name)
        performSegue(withIdentifier: "challengeToAlbum", sender: userIdAndName)
    }
    
    func didTapPosts(with userId: Int, by name: String) {
        let userIdAndName = (id: userId, name: name)
        performSegue(withIdentifier: "challengeToPost", sender: userIdAndName)
    }
}
