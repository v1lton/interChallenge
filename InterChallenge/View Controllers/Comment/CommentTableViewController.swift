import Alamofire
import UIKit

class CommentTableViewController: UITableViewController, Binding {
    
    var postId = Int()
    var userName = String()
    var viewModel: CommentViewModel!
    weak var coordinator: AppCoordinator?
    
    required init(viewModel: CommentViewModel) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 97
        tableView.register(TitleAndDescriptionTableViewCell.self, forCellReuseIdentifier: viewModel.reuseIdentifier)
        self.initBinding()
    }
    
    func initBinding() {
        viewModel.commentViewModels.addObserver(fireNow: false) { [weak self] (commentViewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.postId.addObserver { [weak self] (userId) in
            self?.postId = userId
        }
        
        viewModel.userName.addObserver { [weak self] (userName) in
            self?.userName = userName
            self?.navigationItem.title = "Comentários de \(userName)"
        }
        
        viewModel.error.addObserver(fireNow: false) { [weak self] (error) in
            self?.displayAlert()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commentViewModels.value.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier, for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }
        
        let commentViewModel = viewModel.commentViewModels.value[indexPath.row]
        cell.viewModel = commentViewModel
        
        return cell
    }
    
}
