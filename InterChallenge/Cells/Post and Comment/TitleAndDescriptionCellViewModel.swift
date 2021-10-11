import Foundation

class TitleAndDescriptionCellViewModel {
    var id: Int = 0
    var title: String = ""
    var body: String = ""
    
    init(model: TitleAndDescription) {
        self.id = model.id
        self.title = model.title
        self.body = model.body
    }
}
