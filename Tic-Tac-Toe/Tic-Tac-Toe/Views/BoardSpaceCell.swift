import UIKit

final class BoardSpaceCell: UICollectionViewCell {
    static let identifier = "BoardSpaceCell"

    // MARK: - Private Properties

    private let imageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // internal properties
    var isFilled: Bool = false
    var player: Player?
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetCell() {
        imageView.image = nil
        isFilled = false
    }
    
    func configure(with player: Player) {
        self.player = player
        imageView.image = player.marker.image
        isFilled = true
    }
}

extension BoardSpaceCell {
    // MARK: - Private Methods
    
    private func setup() {
        backgroundColor = .white
        setupImageView()
    }

    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
}
