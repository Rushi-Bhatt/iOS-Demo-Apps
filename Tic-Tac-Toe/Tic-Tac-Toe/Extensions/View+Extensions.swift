import Foundation
import UIKit

// No need to modify during the interview
extension UIView {
    func build(
        titleLabel: UILabel,
        playersStackView: UIStackView,
        currentPlayerLabel: UILabel,
        collectionView: UICollectionView,
        undoButton: UIButton
    ) {
        let views: [UIView] = [
            titleLabel,
            playersStackView,
            currentPlayerLabel,
            collectionView,
            undoButton
        ]

        views.forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            playersStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            playersStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            currentPlayerLabel.topAnchor.constraint(equalTo: playersStackView.bottomAnchor, constant: 20),
            currentPlayerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: currentPlayerLabel.bottomAnchor, constant: 20),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),

            undoButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            undoButton.heightAnchor.constraint(equalToConstant: 75),
            undoButton.widthAnchor.constraint(equalToConstant: 75),
            undoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension UIStackView {
    static func build(
        players: [Player]
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: players.map { PlayerView(player: $0) })
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}

extension UILabel {
    static func build(
        font: UIFont,
        text: String
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UICollectionView {
    static func build() -> UICollectionView {
        let fraction: CGFloat = 1 / 3
        let inset: CGFloat = 2.5

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewCompositionalLayout(section: section))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = false
        return collectionView
    }
}
