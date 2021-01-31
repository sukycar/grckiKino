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
        
        if number < 11 {
            borderColor = Colors.Result.yellow.cgColor
        } else if number < 21 && number > 10{
            borderColor = Colors.Result.orange.cgColor
        } else if number < 31 && number > 20{
            borderColor = Colors.Result.red.cgColor
        } else if number < 41 && number > 30{
            borderColor = Colors.Result.purple.cgColor
        } else if number < 51 && number > 40{
            borderColor = Colors.Result.pink.cgColor
        } else if number < 61 && number > 50{
            borderColor = Colors.Result.lightBlue.cgColor
        } else if number < 71 && number > 60{
            borderColor = Colors.Result.green.cgColor
        } else if number < 81 && number > 70{
            borderColor = Colors.Result.purple.cgColor
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

