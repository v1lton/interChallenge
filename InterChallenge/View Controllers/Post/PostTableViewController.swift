import Alamofire
import UIKit

class PostTableViewController: UITableViewController {
    
    var userId = Int()
    var userName = String()
    var viewModel: PostViewModel!
    weak var coordinator: MainCoordinator?
    
    init(viewModel: PostViewModel) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 97
        tableView.register(TitleAndDescriptionTableViewCell.self, forCellReuseIdentifier: "TitleAndDescriptionCell")
        self.initBinding()
    }
    
    func initBinding() {
        viewModel.postViewModels.addObserver(fireNow: false) { [weak self] (postsViewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.userId.addObserver { [weak self] (userId) in
            self?.userId = userId
        }
        
        viewModel.userName.addObserver { [weak self] (userName) in
            self?.userName = userName
            self?.navigationItem.title = "Postagens de \(userName)"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postViewModels.value.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionCell", for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let postViewModel = viewModel.postViewModels.value[indexPath.row]
        cell.viewModel = postViewModel

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postId = viewModel.postViewModels.value[indexPath.row].id
        self.didTapCell(with: postId, by: self.userName)
    }
}

extension PostTableViewController: TableViewRowNavigable {
    func didTapCell(with postId: Int, by userName: String) {
        self.coordinator?.showComments(with: postId, by: userName)
    }
}
