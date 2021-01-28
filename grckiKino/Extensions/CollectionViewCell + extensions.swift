//
//  CollectionViewCell + extensions.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var cellIdentifier: String {
        let className = NSStringFromClass(self).components(separatedBy: ".")
        if className.count > 0 {
            return className.last ?? ""
        }
        return NSStringFromClass(self).replacingOccurrences(of: "grckiKino.", with: "")
    }
}
