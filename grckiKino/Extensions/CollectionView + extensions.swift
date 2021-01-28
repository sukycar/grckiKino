//
//  CollectionView + extensions.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import Foundation
import UIKit

extension UICollectionView{
    func register(for cellIdentifier:String) {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
