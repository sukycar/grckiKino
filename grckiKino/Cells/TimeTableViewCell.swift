//
//  TimeTableViewCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import UIKit

protocol RemoveEndedDraw{
    func removeRow(for index: Int)
}

class TimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    private var newTime = Date()
    private var timeLeft = TimeInterval()
    private var timer = Timer()
    var removeRow : RemoveEndedDraw?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.styleViews()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
            self?.timeLeft -= 1
            self?.newTime -= 1
            if self?.timeLeft ?? 0 > 0 {
                if self?.timeLeft ?? 0 > 3599 {
                    self?.counterLabel.textColor = Colors.Basic.white
                    self?.counterLabel.text = StaticHelpers.dateTimeFormatterHHmmss.string(from: self?.newTime ?? Date())
                } else if self?.timeLeft ?? 0 < 10 {
                    self?.counterLabel.textColor = Colors.Basic.red
                    self?.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: self?.newTime ?? Date())
                } else {
                    self?.counterLabel.textColor = Colors.Basic.white
                    self?.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: self?.newTime ?? Date())
                }
            } else {
                self?.counterLabel.text = "Vreme je isteklo"
                self?.counterLabel.textColor = Colors.Basic.white
                self?.isUserInteractionEnabled = false
            }
        })
        RunLoop.main.add(timer, forMode: .common)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func set(with draw: Draw){
        self.startTimeLabel.text = StaticHelpers.dateTimeFormatterHHmm.string(from: draw.getTimeValue())
        self.counterLabel.text = draw.getTimerStringValue()
        self.newTime = draw.getTimer()
        self.timeLeft = draw.getTimeValue().timeIntervalSince1970 - Date().timeIntervalSince1970
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func styleViews(){
        self.startTimeLabel.textColor = Colors.Basic.white
        self.counterLabel.textColor = Colors.Basic.white
        self.backgroundColor = Colors.Basic.black
        self.selectionStyle = .none
    }
}
