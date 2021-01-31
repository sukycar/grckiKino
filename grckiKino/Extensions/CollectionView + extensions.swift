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

extension UICollectionView{
    func registerHeaderView(for reusableViewIdentifier: String) {
        let nib = UINib(nibName: reusableViewIdentifier, bundle: Bundle.main)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reusableViewIdentifier)
    }
    
    func registerFooterView(for reusableViewIdentifier: String) {
        let nib = UINib(nibName: reusableViewIdentifier, bundle: Bundle.main)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reusableViewIdentifier)
    }
    
}

extension UICollectionReusableView {
    static var reusableViewIdentifier: String {
        let seperated = NSStringFromClass(self).components(separatedBy: ".")
        if seperated.count > 1 {
            return seperated[1]
        }
        return seperated[0]
    }
}
