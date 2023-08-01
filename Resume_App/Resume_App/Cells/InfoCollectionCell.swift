import UIKit

final class InfoCollectionCell: UICollectionViewCell {

    static let identifier = "InfoCollectionCell"
    private let dataManager = DataManager.shared
   
    private lazy var titleResume: UILabel = {
        let label = UILabel()
        label.text = "title".localized
        label.textColor = .textColorBlack
        label.font = .headline1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = dataManager.avatar
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = dataManager.userName
        label.textColor = .textColorBlack
        label.font = .headline2
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = dataManager.level
        label.textColor = .textColorGray
        label.font = .headline3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var location: UILabel = {
        let label = UILabel()
        label.text = dataManager.location
        label.textColor = .textColorGray
        label.font = .headline3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        configureStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(titleResume)
        contentView.addSubview(imageView)
        contentView.addSubview(userName)
        contentView.addSubview(levelLabel)
        contentView.addSubview(locationStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleResume.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            titleResume.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: titleResume.bottomAnchor, constant: 42),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            userName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userName.bottomAnchor.constraint(equalTo: levelLabel.topAnchor, constant: -4),
            
            levelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            levelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            levelLabel.bottomAnchor.constraint(equalTo: locationStackView.topAnchor),
            
            locationStackView.heightAnchor.constraint(equalToConstant: 20),
            locationStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            locationStackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            locationStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureStackView() {
        let locationImageView = UIImageView(image: UIImage(named: "frame"))
        locationStackView.addArrangedSubview(locationImageView)
        locationStackView.addArrangedSubview(location)
        
    }
}

