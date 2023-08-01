import UIKit

class SupplementaryViewCell: UICollectionReusableView {
    
    static let identifier = "header"
    var buttonAction: (() -> Void)?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColorBlack
        label.font = .header
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(editButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            titleLabel.widthAnchor.constraint(equalToConstant: 120),
          
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        header: String?,
        buttonImage: UIImage?
    ) {
        titleLabel.text = header
        editButton.isHidden = buttonImage == nil
        let image = buttonImage?
            .withTintColor(.textColorBlack)
            .withRenderingMode(.alwaysOriginal)
        editButton.setImage(image, for: .normal)
    }
    
    @objc private func editButtonTapped() {
        buttonAction?()
    }
}
