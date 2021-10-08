import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAlbums(with userId: Int, by name: String)
    func didTapPosts(with userId: Int, by name: String)
}

class UserTableViewCell: UITableViewCell {
    
    let initialsView = UIView()
    let initialsLabel = UILabel()
    let nameLabel = UILabel()
    let separatorView = UIView()
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
        
        //Style
        self.setupInitialsViewStyle()
        self.setupNameLabelStyle()
        self.setupSeparatorViewStyle()
        self.setupNameLabelStyle()
        self.setupUserNameLabelStyle()
        self.setupEmailLabelStyle()
        self.setupPhoneLabelStyle()
        
        //Constraints
        self.setupInitialsViewConstraints()
        self.setupInitialsLabelConstraints()
        self.setupNameLabelConstraints()
        self.setupSeparatorViewConstraints()
        self.setupUserNameLabelConstraints()
        self.setupEmailLabelConstraints()
        self.setupPhoneLabelConstraints()
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
    
    private func setupInitialsViewStyle() {
        self.initialsView.backgroundColor = .systemYellow
    }
    
    private func setupInitialsLabelStyle() {
        self.initialsLabel.text = "initials"
        self.initialsLabel.numberOfLines = 0
        self.initialsLabel.textAlignment = .center
        self.initialsLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupSeparatorViewStyle() {
        self.separatorView.backgroundColor = .lightGray
    }
    
    private func setupNameLabelStyle() {
        self.nameLabel.text = "name"
        self.nameLabel.numberOfLines = 0
        self.nameLabel.textAlignment = .center
        self.nameLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupUserNameLabelStyle() {
        self.userNameLabel.text = "username"
        self.userNameLabel.numberOfLines = 0
        self.userNameLabel.textAlignment = .natural
        self.userNameLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupEmailLabelStyle() {
        self.emailLabel.text = "email"
        self.emailLabel.numberOfLines = 0
        self.emailLabel.textAlignment = .natural
        self.emailLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupPhoneLabelStyle() {
        self.phoneLabel.text = "phone"
        self.phoneLabel.numberOfLines = 0
        self.phoneLabel.textAlignment = .natural
        self.phoneLabel.lineBreakMode = .byTruncatingTail
    }
    
    
    // MARK: - Constraints
    
    private func setupInitialsViewConstraints() {
        self.initialsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.initialsView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.initialsView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.initialsView.heightAnchor.constraint(equalToConstant: 88),
            self.initialsView.widthAnchor.constraint(equalToConstant: 88)
        ])
    }
    
    private func setupInitialsLabelConstraints() {
        self.initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.initialsLabel.centerXAnchor.constraint(equalTo: self.initialsView.centerXAnchor),
            self.initialsLabel.centerYAnchor.constraint(equalTo: self.initialsView.centerYAnchor)
        ])
    }
    
    private func setupNameLabelConstraints() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.nameLabel.topAnchor.constraint(equalTo: self.initialsView.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupSeparatorViewConstraints() {
        self.separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.separatorView.widthAnchor.constraint(equalToConstant: 2),
            self.separatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.separatorView.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 32),
            self.separatorView.leadingAnchor.constraint(equalTo: self.initialsView.trailingAnchor, constant: 32)
        ])
    }
    
    private func setupUserNameLabelConstraints() {
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 16),
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: 16),
            self.userNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    private func setupEmailLabelConstraints() {
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.emailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 16),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: 16),
            self.emailLabel.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupPhoneLabelConstraints() {
        self.phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.phoneLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 16),
            self.phoneLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: 16),
            self.phoneLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func buildViewHierarchy() {
        self.contentView.addSubview(initialsView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(separatorView)
        self.contentView.addSubview(userNameLabel)
        self.contentView.addSubview(emailLabel)
        self.contentView.addSubview(phoneLabel)
        self.contentView.addSubview(albumsButton)
        self.contentView.addSubview(postsButton)
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
