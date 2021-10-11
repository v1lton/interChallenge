import Foundation

class PhotoCellViewModel {
    let photoUrl: String
    let title: String
    let thumbnailUrl: String
    
    init(photo: Photo) {
        self.photoUrl = photo.url
        self.title = photo.title
        self.thumbnailUrl = photo.thumbnailUrl
    }
}
