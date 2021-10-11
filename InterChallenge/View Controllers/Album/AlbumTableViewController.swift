import Alamofire
import UIKit

class AlbumTableViewController: UITableViewController {

    var userId = Int()
    var userName = String()
    private var albumsViewModel = [AlbumCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Álbuns de \(userName)"
        self.tableView.estimatedRowHeight = 44
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumCell")
        fillAlbums(from: userId)
    }
    
    private func fillAlbums(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/albums?userId=\(userId)").validate().responseJSON { response in
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
                    let models = try JSONDecoder().decode([Album].self, from: data)
                    self.albumsViewModel = models.map({return AlbumCellViewModel(album: $0)})
                    self.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsViewModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        
        let albumViewModel = albumsViewModel[indexPath.row]
        cell.viewModel = albumViewModel

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = albumsViewModel[indexPath.row].id
        self.didTapCell(with: albumId, by: self.userName)
    }

    // MARK: - Navigation
    
    public func setUser(id: Int, name: String) {
        self.userId = id
        self.userName = name
    }
}

extension AlbumTableViewController: TableViewRowNavigable {
    func didTapCell(with albumId: Int, by userName: String) {
        let photoTableViewController = PhotoTableViewController()
        photoTableViewController.setPhoto(with: albumId, by: userName)
        self.navigationController?.pushViewController(photoTableViewController, animated: true)
    }
}
