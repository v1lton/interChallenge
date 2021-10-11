import Alamofire
import UIKit

class AlbumTableViewController: UITableViewController, Binding {

    var userId = Int()
    var userName = String()
    var viewModel: AlbumViewModel!
    weak var coordinator: AppCoordinator?
    
    required init(viewModel: AlbumViewModel) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 44
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: viewModel.reuseIdentifier)
        self.initBinding()
    }
    
    func initBinding() {
        viewModel.albumViewModels.addObserver(fireNow: false) { [weak self] (albumViewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.userId.addObserver { [weak self] (userId) in
            self?.userId = userId
        }
        
        viewModel.userName.addObserver { [weak self] (userName) in
            self?.userName = userName
            self?.navigationItem.title = "Álbuns de \(userName)"
        }
        
        viewModel.error.addObserver(fireNow: false) { [weak self] (error) in
            self?.displayAlert()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumViewModels.value.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        
        let albumViewModel = viewModel.albumViewModels.value[indexPath.row]
        cell.viewModel = albumViewModel

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = viewModel.albumViewModels.value[indexPath.row].id
        self.didTapCell(with: albumId, by: self.userName)
    }
    
}

extension AlbumTableViewController: TableViewRowNavigable {
    func didTapCell(with albumId: Int, by userName: String) {
        self.coordinator?.showPhotos(with: albumId, by: userName)
    }
}
