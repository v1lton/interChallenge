import Alamofire
import UIKit

//TODO: conformar ao protocolo

class PhotoTableViewController: UITableViewController {

    var albumId = Int()
    var userName = String()
    var viewModel: PhotoViewModel!
    
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
    
    //TODO: Quem tem que ficar responsável por isso é o viewModel da célula details. Eu só preciso enviar o Data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = viewModel.photoViewModels.value[indexPath.row]
        AF.download(photo.photoUrl).responseData { response in
            switch response.result {
            case .success(let data):
                self.didTapCell(with: UIImage(data: data)!, with: photo.title)
            default:
                break
            }
        }
    }

    // MARK: - Navigation
    
    //TODO: refatorar esses nomes
    private func didTapCell(with photo: UIImage, with description: String) {
        let detailsViewController = DetailsViewController(viewModel: DetailsViewModel(with: photo, by: description))
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}
