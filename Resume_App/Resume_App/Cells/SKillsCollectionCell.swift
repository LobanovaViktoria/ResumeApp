import UIKit

enum SkillCellType {
    case common
    case edit
    case add
}

final class SKillsCollectionCell: UICollectionViewCell {

    static let identifier = "SkillsCollectionCell"
    private let dataManager = DataManager.shared
    private var type: SkillCellType = .add
    private var buttonAction: (() -> Void)?
    let cellHeight: CGFloat = 44
    private let leftPadding: CGFloat = 24
    private let imageLeftPadding: CGFloat = 10
    private let imageRightPadding: CGFloat = 15
    private let addImagePadding: CGFloat = 24
    private let buttonWidth: CGFloat = 14
    
    private lazy var skillLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColorBlack
        label.textAlignment = .center
        label.font = .textFont
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
//        setupLayout()
        backgroundColor = .backgroundGray
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(skillLabel)
        contentView.addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let rightConstant: CGFloat = self.type == .common ? 24 : 48
        let bWidth: CGFloat = self.type == .common ? 0 : buttonWidth
        
        NSLayoutConstraint.activate([
            skillLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            skillLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            skillLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -rightConstant),
            
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            button.widthAnchor.constraint(equalToConstant: bWidth),
            button.heightAnchor.constraint(equalToConstant: bWidth),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: bWidth == 0 ? 0 : -24),
            ])
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let widthDelta = self.type == .edit ? buttonWidth + imageLeftPadding : 0
        var labelWidth = skillLabel.sizeThatFits(CGSize(width: size.width - 48 - widthDelta, height: cellHeight)).width
        
        switch type {
            
        case .common:
            return CGSize(width: labelWidth + leftPadding + leftPadding, height: cellHeight)
        case .edit:
            return CGSize(width: labelWidth + leftPadding + imageLeftPadding + buttonWidth + addImagePadding, height: cellHeight)
        case .add:
            return CGSize(width: addImagePadding * 2 + buttonWidth, height: cellHeight)
        }
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
    
    func configure(with skill: String?, action: (() -> Void)?, type: SkillCellType) {
        buttonAction = action
        skillLabel.text = skill
        skillLabel.isHidden = skill?.isEmpty ?? true
        self.type = type
        switch type {
            
        case .common:
            
            button.setImage(nil, for: .normal)
            button.isHidden = true
        case .edit:
            let image = UIImage(systemName: "xmark")?
                        .withTintColor(.textColorBlack)
                        .withRenderingMode(.alwaysOriginal)
            button.setImage(image, for: .normal)
            button.isHidden = false
        case .add:
            let image = UIImage(systemName: "plus")?
                        .withTintColor(.textColorBlack)
                        .withRenderingMode(.alwaysOriginal)
            button.setImage(image, for: .normal)
            button.isHidden = false
        }
        
        setNeedsLayout()
        layoutIfNeeded()
    }
}

