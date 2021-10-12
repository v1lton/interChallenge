import UIKit

class DetailsView: UIView {
    
    var detailsImageView = UIImageView()
    var nameLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        self.setupConstraints()
        self.setupStyle()
        self.setupDetailImageViewStyle()
        self.setupNameLabelViewStyle()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        self.backgroundColor = .white
    }
    
    private func setupDetailImageViewStyle() {
        self.detailsImageView.contentMode = .scaleAspectFit
        self.detailsImageView.clipsToBounds = true
    }
    
    private func setupNameLabelViewStyle() {
        self.nameLabel.text = "name"
        self.nameLabel.font = UIFont.systemFont(ofSize: 17)
        self.nameLabel.numberOfLines = 0
        self.nameLabel.lineBreakMode = .byTruncatingTail
        self.nameLabel.textAlignment = .natural
    }

}

extension DetailsView: ViewConstraints {
    func setupConstraints() {
        self.setupDetailImageViewConstraints()
        self.setupNameLabelConstraints()
    }
    
    private func setupDetailImageViewConstraints() {
        self.addSubview(detailsImageView)
        self.detailsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.detailsImageView.heightAnchor.constraint(equalToConstant: 250),
            self.detailsImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.detailsImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.detailsImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24)
        ])
    }
    
    private func setupNameLabelConstraints() {
        self.addSubview(nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.nameLabel.topAnchor.constraint(equalTo: self.detailsImageView.bottomAnchor, constant: 16)
        ])
    }
}
