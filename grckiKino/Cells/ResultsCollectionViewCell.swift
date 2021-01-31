//
//  ResultsCollectionViewCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//

import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelHolderView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    var borderColor : CGColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.numberLabel.font = UIFont.systemFont(ofSize: 16)
        self.numberLabel.textColor = Colors.Basic.white
        self.backgroundColor = Colors.Basic.black
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func set(with number: Int){
        
        switch number {
        case 1...10:
            borderColor = Colors.Result.yellow.cgColor
        case 11...20:
            borderColor = Colors.Result.orange.cgColor
        case 21...30:
            borderColor = Colors.Result.red.cgColor
        case 31...40:
            borderColor = Colors.Result.purple.cgColor
        case 41...50:
            borderColor = Colors.Result.pink.cgColor
        case 51...60:
            borderColor = Colors.Result.lightBlue.cgColor
        case 61...70:
            borderColor = Colors.Result.green.cgColor
        case 71...80:
            borderColor = Colors.Result.purple.cgColor
        default:
            return
        }
        
        labelHolderView.layer.borderColor = self.borderColor
        labelHolderView.layer.borderWidth = 2
        labelHolderView.layer.cornerRadius = self.frame.size.height / 2
        
        numberLabel.text = String(number)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
}

