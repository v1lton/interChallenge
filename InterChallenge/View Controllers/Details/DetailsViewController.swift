import UIKit

class DetailsViewController: UIViewController {
    var detailsView = DetailsView()
    var photoUrl = String()
    var photo = UIImage()
    var name = String()
    
//    var detailsView: DetailsView {
//        return view as! DetailsView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.detailsImageView.image = photo
        detailsView.nameLabel.text = name
        detailsView.backgroundColor = .white
        self.view = detailsView
    }
    
//    override func loadView() {
//        let detailsView = DetailsView()
//        detailsView.detailsImageView = UIImageView(image: photo)
//        detailsView.nameLabel.text = name
//        self.view = detailsView
//    }
    
    // TODO: retirar UIImage
    public func setDetails(for photo: UIImage, with name: String) {
        self.photo = photo
        self.name = name
    }
}
