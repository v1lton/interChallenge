import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAlbums(with userId: Int, by name: String)
    func didTapPosts(with userId: Int, by name: String)
}

class UserTableViewCell: UITableViewCell {
    
    let initialsView = UIView()
    let initialsLabel = UILabel()
    let nameLabel = UILabel()
    let userNameLabel = UILabel()
    let emailLabel = UILabel()
    let phoneLabel = UILabel()
    let albumsButton = UIButton()
    let postsButton = UIButton()
    
    var id: Int = 0
    weak var delegate: UserTableViewCellDelegate?
    
    weak var userViewModel: UserViewModel! {
        didSet {
            self.id = userViewModel.id
            self.initialsLabel.text = userViewModel.initialsLabel
            self.nameLabel.text = userViewModel.nameLabel
            self.userNameLabel.text = userViewModel.userNameLabel
            self.emailLabel.text = userViewModel.emailLabel
            self.phoneLabel.text = userViewModel.phoneLabel
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildViewHierarchy()
        
        self.setupInitialsViewConstraints()
        self.setupInitialsViewStyle()
        
        self.setupInitialsLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(delegate: UserTableViewCellDelegate, row: Int) {
        self.delegate = delegate
        self.backgroundColor = row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
    // MARK: - Styles
    
    fileprivate func setupInitialsViewStyle() {
        self.initialsView.backgroundColor = .systemYellow
    }
    
    
    // MARK: - Constraints
    
    fileprivate func setupInitialsViewConstraints() {
        self.initialsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.initialsView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.initialsView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.initialsView.heightAnchor.constraint(equalToConstant: 88),
            self.initialsView.widthAnchor.constraint(equalToConstant: 88)
        ])
    }
    
    fileprivate func setupInitialsLabelConstraints() {
        self.initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.initialsLabel.centerXAnchor.constraint(equalTo: self.initialsView.centerXAnchor),
            self.initialsLabel.centerYAnchor.constraint(equalTo: self.initialsView.centerYAnchor)
        ])
    }
    
    fileprivate func buildViewHierarchy() {
        self.contentView.addSubview(initialsView)
        self.addSubview(nameLabel)
        self.addSubview(userNameLabel)
        self.addSubview(emailLabel)
        self.addSubview(phoneLabel)
        self.addSubview(albumsButton)
        self.addSubview(postsButton)
        self.initialsView.addSubview(initialsLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func albumsAction(_ sender: UIButton) {
        delegate?.didTapAlbums(with: id, by: nameLabel.text ?? "")
    }
    
    @IBAction func postsAction(_ sender: UIButton) {
        delegate?.didTapPosts(with: id, by: nameLabel.text ?? "")
    }
}
