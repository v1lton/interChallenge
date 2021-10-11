import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "albumNameLabel"
        self.contentView.addSubview(label)
        
        label.text = "album"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    weak var viewModel: AlbumCellViewModel! {
        didSet {
            self.albumNameLabel.text = viewModel.title
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
    
}

extension AlbumTableViewCell: ViewConstraints {
    func setupConstraints() {
        self.setupAlbumNameLabelConstraints()
    }
    
    private func setupAlbumNameLabelConstraints() {
        self.albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.albumNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.albumNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.albumNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.albumNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
}
