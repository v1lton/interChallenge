import Alamofire
import UIKit

class PhotoTableViewController: UITableViewController {

    var albumId = Int()
    var userName = String()
    private var photosViewModel = [PhotoViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fotos de \(userName)"
        self.tableView.estimatedRowHeight = 173
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        fillPhotos(from: albumId)
    }
    
    private func fillPhotos(from albumId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Photo].self, from: data)
                    self.photosViewModel = models.map({return PhotoViewModel(photo: $0)})
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosViewModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }

        let photoViewModel = photosViewModel[indexPath.row]
        cell.viewModel = photoViewModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photosViewModel[indexPath.row]
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
        let detailsViewController = DetailsViewController()
        detailsViewController.setDetails(for: photo, with: description)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    public func setPhoto(with albumId: Int, by userName: String) {
        self.albumId = albumId
        self.userName = userName
    }

}
