import UIKit

final class PlayerView: UIView {
    // MARK: - Private Properties

    private let playerName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initializer

    init(player: Player) {
        super.init(frame: .zero)
        setup(image: player.marker.image, name: player.name)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PlayerView {
    // MARK: - Private Methods

    private func setup(image: UIImage, name: String) {
        setupImageView(image: image)
        setupPlayerName(name: name)
    }

    private func setupImageView(image: UIImage) {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])

        imageView.image = image
    }

    private func setupPlayerName(name: String) {
        addSubview(playerName)
        NSLayoutConstraint.activate([
            playerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            playerName.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            playerName.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8)
        ])

        playerName.text = "\(name): "
    }
}
