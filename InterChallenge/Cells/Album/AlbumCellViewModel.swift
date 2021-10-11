import Foundation

class AlbumCellViewModel {
    let id: Int
    let title: String
    
    init(album: Album) {
        self.id = album.id
        self.title = album.title
    }
}
