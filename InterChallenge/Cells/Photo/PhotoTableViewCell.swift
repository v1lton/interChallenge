import Alamofire
import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    let photoImageView = UIImageView()
    let titleLabel = UILabel()
    
    weak var viewModel: PhotoViewModel! {
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
        self.setupPhotoImageViewStyle()
        self.setupTitleLabelStryle()
        self.setupPhotoImageViewConstraints()
        self.setupTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupPhotoImageViewStyle(){
        self.photoImageView.contentMode = .scaleAspectFit
        self.photoImageView.clipsToBounds = true
    }
    
    private func setupTitleLabelStryle() {
        self.titleLabel.text = "title"
        self.titleLabel.textAlignment = .natural
        self.titleLabel.numberOfLines = 5
        self.titleLabel.baselineAdjustment = .alignBaselines
        self.titleLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func setupPhotoImageViewConstraints() {
        self.contentView.addSubview(photoImageView)
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
        self.contentView.addSubview(titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 60)
        ])
        
    }
}
