import UIKit

extension ViewController {
    func showAlert(for result: GameResult, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let title: String = {
            switch result {
            case let .winner(player):
                return "\(player.name) won the game!"
            case .tie:
                return "Tie"
            }
        }()

        let alert = UIAlertController(title: title, message: "Click ok to continue", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: actionHandler)
        alert.addAction(ok)

        present(alert, animated: true, completion: nil)
    }
}
