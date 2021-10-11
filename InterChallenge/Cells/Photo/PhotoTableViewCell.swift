import Alamofire
import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIdentifier = "photoImageView"
        self.contentView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "titleLabel"
        self.contentView.addSubview(label)
        
        label.text = "title"
        label.textAlignment = .natural
        label.numberOfLines = 5
        label.baselineAdjustment = .alignBaselines
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    weak var viewModel: PhotoCellViewModel! {
        didSet {
            self.titleLabel.text = viewModel.title
            AF.download(viewModel.thumbnailUrl).responseData { response in
                switch response.result {
                case .success(let data):
                    self.photoImageView.image = UIImage(data: data)
                default:
                    break
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.clipsToBounds = true
        self.selectionStyle = .none
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotoTableViewCell: CellConfigurable {
    
    func setupConstraints() {
        self.setupPhotoImageViewConstraints()
        self.setupTitleLabelConstraints()
    }
    
    private func setupPhotoImageViewConstraints() {
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.photoImageView.widthAnchor.constraint(equalToConstant: 150),
            self.photoImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            self.photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 60)
        ])
        
    }
    
}
