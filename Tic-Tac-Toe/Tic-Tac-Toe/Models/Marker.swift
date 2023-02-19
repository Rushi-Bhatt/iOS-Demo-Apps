import UIKit

enum Marker: String {
    case o, x

    var image: UIImage {
        return .init(named: self.rawValue)!
    }
}
