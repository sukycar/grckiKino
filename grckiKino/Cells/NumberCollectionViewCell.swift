//
//  NumberCollectionViewCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import UIKit

protocol NumberSelected{
    func getNumber(number: Int)
}

class NumberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var labelHolderView: UIView!
    
    var selectedNumber : NumberSelected?
    var shouldChangeLabelBackgroundWhenSelected = true
    override var isSelected: Bool {
        willSet{
            onSelected(newValue)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleViews()
    }
    
    func styleViews(){
        numberLabel.textColor = Colors.Basic.white
        numberLabel.font = UIFont.systemFont(ofSize: 16)
        labelHolderView.backgroundColor = .clear
        labelHolderView.layer.cornerRadius = labelHolderView.frame.size.height / 3.1
        labelHolderView.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.Basic.gray.cgColor
    }
    
    func onSelected(_ newValue: Bool){
        if shouldChangeLabelBackgroundWhenSelected {
            labelHolderView.backgroundColor = newValue ? Colors.Selection.blue : .clear
            if let number = Int(numberLabel.text ?? "0") {
                selectedNumber?.getNumber(number: number)
            }
        } else {
            labelHolderView.backgroundColor = newValue ? .clear : Colors.Selection.blue
            if let number = Int(numberLabel.text ?? "0") {
                selectedNumber?.getNumber(number: number)
            }
        }
    }
    

}

