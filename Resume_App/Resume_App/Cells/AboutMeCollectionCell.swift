import UIKit

final class AboutMeCollectionCell: UICollectionViewCell {
    
    static let identifier = "AboutMeCollectionCell"
    private let bottomPadding: CGFloat = 24
    private let horizontalPadding: CGFloat = 16
    
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColorBlack
        label.font = .textFont
        label.textAlignment = .left
        label.numberOfLines = 0
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
            aboutMeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            aboutMeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalPadding),
            aboutMeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalPadding),
            aboutMeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomPadding)
        ])
    }
    
    func configure(with text: String) {
        aboutMeLabel.text = text
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelHeight = aboutMeLabel.sizeThatFits(CGSize(width: size.width - horizontalPadding * 2, height: .infinity)).height
        
        return CGSize(width: size.width, height: labelHeight + bottomPadding)
    }
}

