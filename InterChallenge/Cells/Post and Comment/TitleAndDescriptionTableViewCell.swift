import UIKit

class TitleAndDescriptionTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupTitleLabelStyle()
        self.setupDescriptionLabelStyle()
        self.setupTitleLabelConstraints()
        self.setupDescriptionLabelConstraints()
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
            self.titleLabel.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: 16)
        ])
    }
    
    private func setupDescriptionLabelConstraints() {
        self.contentView.addSubview(descriptionLabel)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.superview!.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.superview!.trailingAnchor, constant: 16),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -8)
        ])
    }
}
