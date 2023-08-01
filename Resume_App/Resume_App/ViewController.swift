import UIKit

final class ViewController: UIViewController {
   
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(InfoCollectionCell.self,
                                forCellWithReuseIdentifier: InfoCollectionCell.identifier)
        collectionView.register(ScillsCollectionCell.self,
                                forCellWithReuseIdentifier: ScillsCollectionCell.identifier)
        collectionView.register(
            SupplementaryViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SupplementaryViewCell.identifier)
        collectionView.register(AboutMeCollectionCell.self,
                                forCellWithReuseIdentifier: AboutMeCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
}

extension ViewController: UICollectionViewDataSource {
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
        case .scills:
            guard let scillsCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ScillsCollectionCell.identifier,
                for: indexPath) as? ScillsCollectionCell else { return UICollectionViewCell() }
            return scillsCell
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
        case .scills:
            return 1
        case .aboutMe:
            return 1
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let section = Section(rawValue: indexPath.section) else { return .zero }
        switch section {
        case .info:
            return CGSize(width: self.collectionView.bounds.width, height: 340)
        case .scills:
            return CGSize(width: self.collectionView.bounds.width, height: 160)
        case .aboutMe:
            return CGSize(width: self.collectionView.bounds.width, height: 68)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
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
}

extension ViewController {
    enum Section: Int, CaseIterable {
        case info
        case scills
        case aboutMe
    }
}
