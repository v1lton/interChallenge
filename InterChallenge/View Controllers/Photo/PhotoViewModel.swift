import Alamofire
import Foundation

class PhotoViewModel: TableViewCompatible {
    var reuseIdentifier: String {
        return "PhotoCell"
    }
    
    var albumId = Observable<Int>(value: 0)
    var userName = Observable<String>(value: "")
    var error = Observable<Bool>(value: false)
    var photoViewModels = Observable<[PhotoCellViewModel]>(value: [])
    
    init(with albumId: Int, by userName: String) {
        self.albumId.value = albumId
        self.userName.value = userName
        self.fillPhotos(from: albumId)
    }
    
    private func fillPhotos(from albumId: Int) {
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)").validate().responseJSON { response in
            guard response.error == nil else {
                self.error.value = true
                return
            }
            
            do {
                if let data = response.data {
                    let models = try JSONDecoder().decode([Photo].self, from: data)
                    self.photoViewModels.value = models.map({return PhotoCellViewModel(photo: $0)})
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        }
    }
}
