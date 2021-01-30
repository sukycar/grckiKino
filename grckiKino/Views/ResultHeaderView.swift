//
//  ResultHeaderView.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//

import UIKit

class ResultHeaderView: UICollectionReusableView {
    @IBOutlet weak var drawTimeLabel: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var drawIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(with draw: DrawResult?){
        if let draw = draw {
            self.backgroundColor = Colors.Selection.gray
            drawTimeLabel.font = UIFont.systemFont(ofSize: 12)
            drawTimeLabel.textColor = Colors.Basic.white
            let time = draw.getTimeValue()
            let timeString = StaticHelpers.dateTimeFormatterHHmm.string(from: time)
            drawTimeLabel.text = "Vreme izvlačenja: \(timeString)"
            separatorLabel.font = UIFont.systemFont(ofSize: 12)
            separatorLabel.textColor = Colors.Basic.white
            separatorLabel.text = " | "
            drawIdLabel.font = UIFont.systemFont(ofSize: 12)
            drawIdLabel.textColor = Colors.Basic.white
            let drawId = String(draw.drawId)
            drawIdLabel.text = "Kolo: \(drawId)"
        }
        
    }
    
}


