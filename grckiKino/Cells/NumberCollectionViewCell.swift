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
    var passedArray = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        styleViews()
        NotificationCenter.default.addObserver(self, selector: #selector(disableInteraction), name: NSNotification.Name(rawValue: "limitReached"), object: nil)
    }
    
    func styleViews(){
        if self.isSmallScreen() {
            numberLabel.font = UIFont.systemFont(ofSize: 12)
            labelHolderView.layer.cornerRadius = labelHolderView.frame.size.height / 4
        } else {
            numberLabel.font = UIFont.systemFont(ofSize: 16)
            labelHolderView.layer.cornerRadius = labelHolderView.frame.size.height / 3.1
        }
        numberLabel.textColor = Colors.Basic.white
        labelHolderView.backgroundColor = .clear
        labelHolderView.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.Basic.gray.cgColor
    }
    
    @objc func disableInteraction(){
        self.isUserInteractionEnabled = false
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

