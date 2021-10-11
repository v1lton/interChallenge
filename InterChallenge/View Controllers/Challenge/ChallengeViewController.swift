import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    
    var viewModel: ChallengeViewModel = ChallengeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Desafio"
        self.tableView.estimatedRowHeight = 233
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        self.initBinding()
    }
    
    func initBinding() {
        viewModel.userViewModels.addObserver(fireNow: false) { [weak self] (userViewModels) in
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userViewModels.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let userViewModel = self.viewModel.userViewModels.value[indexPath.row]
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
}

extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with userId: Int, by name: String) {
        let albumTableViewController = AlbumTableViewController(viewModel: AlbumViewModel(with: userId, by: name))
        self.navigationController?.pushViewController(albumTableViewController, animated: true)
    }
    
    func didTapPosts(with userId: Int, by name: String) {
        let postTableViewController = PostTableViewController(viewModel: PostViewModel(with: userId, by: name))
        self.navigationController?.pushViewController(postTableViewController, animated: true)
    }
}
