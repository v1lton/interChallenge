import UIKit

class TitleAndDescriptionTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "titleLabel"
        self.contentView.addSubview(label)
        
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 21)
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .natural
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "descriptionLabel"
        self.contentView.addSubview(label)
        
        label.text = "description"
        label.baselineAdjustment = .alignBaselines
        label.textAlignment = .natural
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    weak var viewModel: TitleAndDescriptionCellViewModel! {
        didSet {
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.body
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

extension TitleAndDescriptionTableViewCell: ViewConstraints {
    
    func setupConstraints() {
        self.setupTitleLabelConstraints()
        self.setupDescriptionLabelConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
