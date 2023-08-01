import UIKit

final class ResumeViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(InfoCollectionCell.self,
                                forCellWithReuseIdentifier: InfoCollectionCell.identifier)
        collectionView.register(SKillsCollectionCell.self,
                                forCellWithReuseIdentifier: SKillsCollectionCell.identifier)
        collectionView.register(
            SupplementaryViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SupplementaryViewCell.identifier)
        collectionView.register(AboutMeCollectionCell.self,
                                forCellWithReuseIdentifier: AboutMeCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var isInEditableMode: Bool = false
    private var skills: [String] = []
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundWhite
        addSubviews()
        setupLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "alertTitle".localized, message: "alertMessage".localized, preferredStyle:UIAlertController.Style.alert)
        alert.addTextField { (textField : UITextField!) in
            textField.placeholder = "alertPlaceholder".localized
            textField.delegate = self
        }
        
        let save = UIAlertAction(title: "alertSave".localized, style: UIAlertAction.Style.default, handler: { [weak self] saveAction -> Void in
            let textField = alert.textFields![0] as UITextField
            if let skill = textField.text {
                self?.skills.append(skill)
                self?.collectionView.reloadData()
            }
            
            // Save to user defaults
        })
        let cancel = UIAlertAction(title: "alertCancel".localized, style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alert.addAction(cancel)
        alert.addAction(save)
        self.present(alert, animated: true, completion: nil)
    }    
}

extension ResumeViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ResumeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
        switch section {
        case .info:
            guard let infoCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: InfoCollectionCell.identifier,
                for: indexPath) as? InfoCollectionCell else { return UICollectionViewCell() }
            infoCell.backgroundColor = .backgroundGray
            return infoCell
        case .skills:
            guard let skillsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SKillsCollectionCell.identifier,
                for: indexPath) as? SKillsCollectionCell else { return UICollectionViewCell() }
            let type = {
                if !isInEditableMode {
                    return SkillCellType.common
                } else {
                    if skills.count == 0 {
                        return SkillCellType.add
                    } else {
                        if skills.count == indexPath.row {
                            return SkillCellType.add
                        } else {
                            return SkillCellType.edit
                        }
                    }
                }
            }()
            
            skillsCell.configure(
                with: indexPath.row < skills.count ? skills[indexPath.row] : nil,
                action: showAlert,
                type: type)
            return skillsCell
        case .aboutMe:
            guard let aboutMeCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AboutMeCollectionCell.identifier,
                for: indexPath) as? AboutMeCollectionCell else { return UICollectionViewCell() }
            return aboutMeCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .info:
            return 1
        case .skills:
            return isInEditableMode ? skills.count + 1 : skills.count
        case .aboutMe:
            return 1
        }
    }
}

extension ResumeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return .zero }
        switch section {
        case .info:
            return CGSize(width: self.collectionView.bounds.width, height: 340)
        case .skills:
            guard let skillsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SKillsCollectionCell.identifier,
                for: indexPath) as? SKillsCollectionCell else
            {
                return .zero
            }
            let type = {
                if !isInEditableMode {
                    return SkillCellType.common
                } else {
                    if skills.count == 0 {
                        return SkillCellType.add
                    } else {
                        if skills.count == indexPath.row {
                            return SkillCellType.add
                        } else {
                            return SkillCellType.edit
                        }
                    }
                }
            }()
            
            skillsCell.configure(
                with: indexPath.row < skills.count ? skills[indexPath.row] : nil,
                action: showAlert,
                type: type)
            return skillsCell.sizeThatFits(CGSize(width: self.collectionView.bounds.width - 32, height: skillsCell.cellHeight))
        case .aboutMe:
            return CGSize(width: self.collectionView.bounds.width, height: 100)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 12
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        case UICollectionView.elementKindSectionFooter:
            id = "footer"
        default:
            id = ""
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? SupplementaryViewCell else { return UICollectionReusableView() }
        
        if indexPath.section == 1 {
            view.titleLabel.text = "headerSkills".localized
            view.editButton.isHidden = false
            view.buttonAction = { [weak self] in
                guard let self else { return }
                self.isInEditableMode = !self.isInEditableMode
                self.collectionView.reloadData()
            }
        }
        if indexPath.section == 2 {
            view.titleLabel.text = "headerAboutMe".localized
            view.editButton.isHidden = true
        }
        return view
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0  {
            return .zero
        }
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        guard let section = Section(rawValue: section) else { return .zero }
        switch section {
        case .skills:
            return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        case .info, .aboutMe:
            return .zero
        }
    }
}

extension ResumeViewController {
    enum Section: Int, CaseIterable {
        case info
        case skills
        case aboutMe
    }
}
