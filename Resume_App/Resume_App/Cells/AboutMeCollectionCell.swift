import UIKit

final class AboutMeCollectionCell: UICollectionViewCell {

    static let identifier = "AboutMeCollectionCell"
    private let dataManager = DataManager.shared
    
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = dataManager.aboutMe
        label.textColor = .textColorBlack
        label.font = .textFont
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(aboutMeLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            aboutMeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            aboutMeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

