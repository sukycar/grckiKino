//
//  ScreenSelectionCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 29.1.21..
//

import UIKit


class ScreenSelectionCell: UICollectionViewCell {

    var selectedScreen : SelectedScreen = .talon
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectionLabel: UILabel!
    var shouldChangeColorsWhenSelected = true
    override var isSelected: Bool {
        willSet{
            onSelected(newValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func set(with screenType: SelectedScreen){
        selectedScreen = screenType
        imageView.image = selectedScreen.image
        imageView.tintColor = Colors.Selection.lightBlue
        selectionLabel.text = selectedScreen.title
        selectionLabel.font = UIFont.systemFont(ofSize: 11)
        selectionLabel.textColor = Colors.Selection.lightBlue
    }
    
    func onSelected(_ newValue: Bool){
        if shouldChangeColorsWhenSelected {
            imageView.tintColor = newValue ? Colors.Selection.orange : Colors.Selection.lightBlue
            selectionLabel.textColor = newValue ? Colors.Selection.orange : Colors.Selection.lightBlue
        }
    }

}

enum SelectedScreen: CaseIterable {
    case talon
    case results
    case liveDraw
    
    var image: UIImage {
        switch self {
        case .talon:
            return UIImage(named: "img_talon")!
        case .results:
            return UIImage(named: "img_rezultati")!
        case .liveDraw:
            return UIImage(named: "img_izvlacenje")!
        }
    }
    
    var title: String {
        switch self {
        case .talon:
            return "Talon"
        case .results:
            return "Rezultati izvlačenja"
        case .liveDraw:
            return "Izvlačenje uživo"
        }
    }
}
