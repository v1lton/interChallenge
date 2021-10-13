import Alamofire
import Foundation

class DetailsViewModel {
    
    var photoUrl = Observable<String>(value: "")
    var photoData = Observable<Data>(value: Data())
    var name = Observable<String>(value: "")
    
    init(with photoUrl: String, by name: String) {
        self.photoUrl.value = photoUrl
        self.name.value = name
        self.downloadPhotoData(for: photoUrl)
    }
    
    func downloadPhotoData(for url: String) {
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let data):
                self.photoData.value = data
            default:
                break
            }
        }
    }
    
}
