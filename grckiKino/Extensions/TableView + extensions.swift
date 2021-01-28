//
//  TableView + extensions.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import UIKit

extension UITableView {
    func register(for cellIdentifier:String) {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
