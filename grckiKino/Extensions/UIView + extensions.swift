//
//  UIView + extensions.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//

import Foundation
import UIKit

extension UIView {
    
    public func isSmallScreen() -> Bool {
        if UIScreen.main.bounds.height < 668 {
            return true
        }
        return false
    }
}
