import UIKit

final class ViewController: UIViewController {
    // Players
    private let player1: Player = .init(name: "John Doe", marker: .o)
    private let player2: Player = .init(name: "Joe Smith", marker: .x)

    // UI
    private lazy var playerStackView: UIStackView = UIStackView.build(players: [player1, player2])

    private let titleLabel: UILabel = UILabel.build(font: .systemFont(ofSize: 24, weight: .bold),
                                                    text: "Tic Tac Toe")

    private let currentPlayerLabel: UILabel = UILabel.build(font: .systemFont(ofSize: 16),
                                                            text: "Current Player: John Doe")
    
    private var moves: [IndexPath] = []
    private var filledPositions: [Int: Player] = [:]
    
    var isCurrentPlayer1: Bool = true  {
        didSet {
            let currentPlayer = isCurrentPlayer1 ? player1 : player2
            currentPlayerLabel.text = "Current Player: \(currentPlayer.name)"
        }
    }
    

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.build()
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BoardSpaceCell.self, forCellWithReuseIdentifier: BoardSpaceCell.identifier)
        return collectionView
    }()

    private let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(systemName: "arrowshape.turn.up.left"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.build(
            titleLabel: titleLabel,
            playersStackView: playerStackView,
            currentPlayerLabel: currentPlayerLabel,
            collectionView: collectionView,
            undoButton: undoButton
        )
        
        undoButton.addTarget(self, action: #selector(onUndo), for: .touchDown)
    }

    private enum Constant {
        static let numberOfRows: Int = 3
    }
    
    @objc private func onUndo() {
        guard let lastMove = self.moves.popLast() else { return }
        filledPositions[lastMove.row] = nil
        guard let cell = collectionView.cellForItem(at: lastMove) as? BoardSpaceCell else { return }
        cell.resetCell()
        isCurrentPlayer1.toggle()
    }
    
    private func checkForGameResult() {
        let winningPairs = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        for pair in winningPairs {
            if let p0 = filledPositions[pair[0]],
               let p1 = filledPositions[pair[1]],
               let p2 = filledPositions[pair[2]],
               p0 == p1 && p1 == p2 {
                print("victory")
                showAlert(for: .winner(p0))
                return
            }
        }
        
        if filledPositions.count == 9 {
            print("Tie")
            showAlert(for: .tie)
            return
        }
        print("keep going")
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constant.numberOfRows * Constant.numberOfRows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardSpaceCell.identifier, for: indexPath) as? BoardSpaceCell else {
            return .init()
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? BoardSpaceCell else { return }
        guard !cell.isFilled else { return }
        let currentPlayer = isCurrentPlayer1 ? player1 : player2
        cell.configure(with: currentPlayer)
        moves.append(indexPath)
        filledPositions[indexPath.row] = currentPlayer
        checkForGameResult()
        isCurrentPlayer1.toggle()
    }
    
}
