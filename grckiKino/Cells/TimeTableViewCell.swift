//
//  TimeTableViewCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.styleViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(with startTime: Date){
        self.startTimeLabel.text = StaticHelpers.dateTimeFormatterHHmm.string(from: startTime)
        self.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: (Date() + 300))
    }
    
    func styleViews(){
        self.startTimeLabel.textColor = Colors.Basic.white
        self.counterLabel.textColor = Colors.Basic.white
        self.backgroundColor = Colors.Basic.black
        self.selectionStyle = .none
    }
}
