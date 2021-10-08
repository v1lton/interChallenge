import UIKit

class AlbumTableViewCell: UITableViewCell {

    let albumNameLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupAlbumNameLabelStyle()
        self.setupAlbumNameLabelConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupAlbumNameLabelStyle() {
        self.albumNameLabel.text = "album"
        self.albumNameLabel.textAlignment = .natural
        self.albumNameLabel.numberOfLines = 0
        self.albumNameLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupAlbumNameLabelConstraints() {
        self.contentView.addSubview(albumNameLabel)
        self.albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.albumNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.albumNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.albumNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.albumNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
}
