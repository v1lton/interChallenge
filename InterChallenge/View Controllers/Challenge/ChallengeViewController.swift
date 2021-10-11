import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    
    var viewModel: ChallengeViewModel = ChallengeViewModel()
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Desafio"
        self.setCellStyle()
        self.initBinding()
    }
    
    func initBinding() {
        viewModel.userViewModels.addObserver(fireNow: false) { [weak self] (userViewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.error.addObserver(fireNow: false) { [weak self] (error) in
            self?.displayAlert()
        }
    }
    
    private func setCellStyle() {
        self.tableView.estimatedRowHeight = 233
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: viewModel.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.userViewModels.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let userViewModel = self.viewModel.userViewModels.value[indexPath.row]
        cell.userViewModel = userViewModel
        cell.bind(delegate: self, row: indexPath.row)
        
        return cell
    }
    
}

extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with userId: Int, by name: String) {
        self.coordinator?.showAlbums(with: userId, by: name)
    }
    
    func didTapPosts(with userId: Int, by name: String) {
        self.coordinator?.showPosts(with: userId, by: name)
    }
}
