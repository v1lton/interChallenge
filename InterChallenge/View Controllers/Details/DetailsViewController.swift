import UIKit

class DetailsViewController: UIViewController {
    //lazy var detailsView = DetailsView()
    var photoUrl = String()
    var photo = UIImage()
    var name = String()
    var viewModel: DetailsViewModel!
    
    init(viewModel: DetailsViewModel) {
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
        //detailsView.detailsImageView.image = photo
       // detailsView.nameLabel.text = name
        //detailsView.backgroundColor = .white
        //self.view = detailsView
    }
    
    override func loadView() {
        let detailsView = DetailsView()
        detailsView.setup(viewModel: self.viewModel)
        self.view = detailsView
    }
    
    func initBinding() {
        
        viewModel.photo.addObserver { [weak self] (photo) in
            self?.photo = photo
        }
        
        viewModel.name.addObserver { [weak self] (name) in
            self?.name = name
        }
    }
    
}
