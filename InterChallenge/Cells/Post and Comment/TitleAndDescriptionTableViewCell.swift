import UIKit

class TitleAndDescriptionTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupTitleLabelStyle()
        self.setupDescriptionLabelStyle()
        self.setupTitleLabelConstraints()
        self.setupDescriptionLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    weak var viewModel: TitleAndDescriptionViewModel! {
        didSet {
            self.titleLabel.text = viewModel.title
            self.descriptionLabel.text = viewModel.body
        }
    }
    
    private func setupTitleLabelStyle() {
        self.titleLabel.text = "title"
        self.titleLabel.font = UIFont.systemFont(ofSize: 21)
        self.titleLabel.baselineAdjustment = .alignBaselines
        self.titleLabel.textAlignment = .natural
        self.titleLabel.numberOfLines = 2
        self.titleLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupDescriptionLabelStyle() {
        self.descriptionLabel.text = "description"
        self.descriptionLabel.baselineAdjustment = .alignBaselines
        self.descriptionLabel.textAlignment = .natural
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.lineBreakMode = .byTruncatingTail
    
    }
    
    private func setupTitleLabelConstraints() {
        self.contentView.addSubview(titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        self.contentView.addSubview(descriptionLabel)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
}
