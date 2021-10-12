import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAlbums(with userId: Int, by name: String)
    func didTapPosts(with userId: Int, by name: String)
}

class UserTableViewCell: UITableViewCell {
    
    lazy var initialsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        
        view.backgroundColor = .systemYellow
        return view
    }()
    
    lazy var initialsLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "initialsLabel"
        self.initialsView.addSubview(label)
        
        label.text = "initials"
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "nameLabel"
        self.contentView.addSubview(label)
        
        label.text = "name"
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.accessibilityIdentifier = "separatorView"
        self.contentView.addSubview(view)
        
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "userNameLabel"
        self.contentView.addSubview(label)
        
        label.text = "username"
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "emailLabel"
        self.contentView.addSubview(label)
        
        label.text = "email"
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "phoneLabel"
        self.contentView.addSubview(label)
        
        label.text = "phone"
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.accessibilityIdentifier = "stackView"
        self.contentView.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    lazy var albumsButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = "albumsButton"
        self.stackView.addArrangedSubview(button)
        
        button.setTitle("ÁLBUNS", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.lineBreakMode = .byTruncatingMiddle
        button.addTarget(self, action: #selector(albumsAction), for: .touchUpInside)
        return button
    }()
    
    lazy var postsButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = "postsButton"
        self.stackView.addArrangedSubview(button)
        
        button.setTitle("POSTAGENS", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.lineBreakMode = .byTruncatingMiddle
        button.addTarget(self, action: #selector(postsAction), for: .touchUpInside)
        return button
    }()
    
    var id: Int = 0
    weak var delegate: UserTableViewCellDelegate?
    
    weak var userViewModel: UserCellViewModel! {
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
        
        self.selectionStyle = .none
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(delegate: UserTableViewCellDelegate, by row: Int) {
        self.delegate = delegate
        self.backgroundColor = row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
    }
    
    @objc func albumsAction(sender: UIButton!) {
        delegate?.didTapAlbums(with: id, by: nameLabel.text ?? "")
    }
    
    @objc func postsAction(sender: UIButton!) {
        delegate?.didTapPosts(with: id, by: nameLabel.text ?? "")
    }
}

extension UserTableViewCell: ViewConstraints {
    
    func setupConstraints() {
        self.setupInitialsViewConstraints()
        self.setupInitialsLabelConstraints()
        self.setupNameLabelConstraints()
        self.setupSeparatorViewConstraints()
        self.setupUserNameLabelConstraints()
        self.setupEmailLabelConstraints()
        self.setupPhoneLabelConstraints()
        self.setupStackViewConstraints()
        self.setupAlbumsButtonConstraints()
        self.setupPostsButtonConstraints()
    }
    
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
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: 16),
            self.userNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    private func setupEmailLabelConstraints() {
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.emailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: 16),
            self.emailLabel.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupPhoneLabelConstraints() {
        self.phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.phoneLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.phoneLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: 16),
            self.phoneLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupStackViewConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.phoneLabel.bottomAnchor, constant: 64),
            self.stackView.topAnchor.constraint(equalTo: self.separatorView.bottomAnchor, constant: 24),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupAlbumsButtonConstraints() {
        self.albumsButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPostsButtonConstraints() {
        self.postsButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
