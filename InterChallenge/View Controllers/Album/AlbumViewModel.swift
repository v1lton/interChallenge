import Alamofire
import Foundation

class AlbumViewModel: TableViewCompatible {
    
    var reuseIdentifier: String {
        return "AlbumCell"
    }
    
    var userId = Observable<Int>(value: 0)
    var userName = Observable<String>(value: "")
    var error = Observable<Bool>(value: false)
    var albumViewModels = Observable<[AlbumCellViewModel]>(value: [])
    
    init(with userId: Int, by userName: String) {
        self.userId.value = userId
        self.userName.value = userName
        self.fillAlbums(from: userId)
    }
    
    private func fillAlbums(from userId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/albums?userId=\(userId)").validate().responseJSON { response in
            guard response.error == nil else {
                self.error.value = true
                return
            }
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Album].self, from: data)
                    self.albumViewModels.value = models.map({return AlbumCellViewModel(album: $0)})
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
    
}
