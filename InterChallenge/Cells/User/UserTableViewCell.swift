import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAlbums(with userId: Int, by name: String)
    func didTapPosts(with userId: Int, by name: String)
}

class UserTableViewCell: UITableViewCell {
    
    let initialsContainer = UIView()
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
        self.setupInitialsLabel()
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
    
    fileprivate func setupInitialsLabelStyle() {
        self.initialsLabel.frame = CGRect(x: 0, y: 0, width: 88, height: 88)
        self.initialsLabel.backgroundColor = .yellow
    }
    
    fileprivate func setupInitialsContainer() {
        self.initialsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.initialsContainer.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 30),
            self.initialsContainer.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.initialsContainer.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        self.initialsContainer.backgroundColor = .yellow
    }
    
    fileprivate func setupInitialsLabel() {
        self.initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.initialsLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.initialsLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
        ])
    }
    
    fileprivate func buildViewHierarchy() {
        self.addSubview(initialsLabel)
        self.addSubview(nameLabel)
        self.addSubview(userNameLabel)
        self.addSubview(emailLabel)
        self.addSubview(phoneLabel)
        self.addSubview(albumsButton)
        self.addSubview(postsButton)
        self.addSubview(initialsContainer)
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
