//
//  NumberCollectionViewCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import UIKit

class NumberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleViews()
    }
    
    func styleViews(){
        numberLabel.textColor = Colors.Basic.white
        numberLabel.font = UIFont.systemFont(ofSize: 16)
    }

}
