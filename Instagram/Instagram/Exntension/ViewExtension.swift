//
//  ViewExtension.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/11/21.
//

import UIKit

extension UIView {

    public var width: CGFloat {
        frame.size.width
    }
    
    public var height: CGFloat {
        frame.size.height
    }
    
    public var top: CGFloat {
        frame.origin.y
    }
    
    public var bottom: CGFloat {
        frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        frame.origin.x
    }
    
    public var right: CGFloat {
        frame.origin.x + frame.size.width
    }
}

extension String {
    public var firebaseSafeString: String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
