//
//  TableViewCell + extension.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import UIKit

extension UITableViewCell {
    static var cellIdentifier: String {
        let className = NSStringFromClass(self).components(separatedBy: ".")
        if className.count > 0 {
            return className.last ?? ""
        }
        return NSStringFromClass(self).replacingOccurrences(of: "grckiKino.", with: "")
    }
}
