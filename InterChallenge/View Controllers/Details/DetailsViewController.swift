import UIKit

class DetailsViewController: UIViewController, Binding {
    
    var detailsView = DetailsView()
    var photo = UIImage()
    var name = String()
    var viewModel: DetailsViewModel!
    weak var coordinator: AppCoordinator?
    
    required init(viewModel: DetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalhes"
        self.initBinding()
    }
    
    override func loadView() {
        self.view = detailsView
    }
    
    func initBinding() {
        
        viewModel.photoData.addObserver(fireNow: false) { [weak self] (photoData) in
            self?.detailsView.detailsImageView.image = UIImage(data: photoData) ?? UIImage()
        }
        
        viewModel.name.addObserver { [weak self] (name) in
            self?.detailsView.nameLabel.text = name
        }
    }
    
}
