import Alamofire
import UIKit

//TODO: conformar ao protocolo

class PhotoTableViewController: UITableViewController {

    var albumId = Int()
    var userName = String()
    var viewModel: PhotoViewModel!
    weak var coordinator: AppCoordinator?
    
    init(viewModel: PhotoViewModel) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 173
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        self.initBinding()
    }
    
    func initBinding() {
        viewModel.photoViewModels.addObserver(fireNow: false) { [weak self] (pgotoViewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.albumId.addObserver { [weak self] (albumId) in
            self?.albumId = albumId
        }
        
        viewModel.userName.addObserver { [weak self] (userName) in
            self?.userName = userName
            self?.navigationItem.title = "Fotos de \(userName)"
        }
        
        viewModel.error.addObserver(fireNow: false) { [weak self] (error) in
            self?.displayAlert()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photoViewModels.value.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }

        let photoViewModel = viewModel.photoViewModels.value[indexPath.row]
        cell.viewModel = photoViewModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = viewModel.photoViewModels.value[indexPath.row]
        self.didTapCell(with: photo.photoUrl, by: photo.title)
    }

    private func didTapCell(with photoUrl: String, by description: String) {
        self.coordinator?.showDetails(with: photoUrl, by: description)
    }
    
}
