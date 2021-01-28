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
    private var newTime = Date()
    private var timeLeft = TimeInterval()
    private var timer = Timer()
    private var timeIsUp = Bool()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.styleViews()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
            self?.timeLeft -= 1
            if self?.timeLeft ?? 0 >= 0 {
                if self?.timeLeft ?? 0 > 3599 {
                    self?.counterLabel.textColor = Colors.Basic.white
                    self?.counterLabel.text = StaticHelpers.dateTimeFormatterHHmmss.string(from: self?.newTime ?? Date())
                } else if self?.timeLeft ?? 0 < 10 && self?.timeLeft != 0{
                    self?.counterLabel.textColor = Colors.Basic.red
                    self?.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: self?.newTime ?? Date())
                } else {
                    self?.counterLabel.textColor = Colors.Basic.white
                    self?.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: self?.newTime ?? Date())
                }
                } else {
                    self?.counterLabel.text = "Vreme isteklo"
                    self?.timer.invalidate()
                    self?.timeIsUp = true
                }
            
        })
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
//            self?.newTime -= 1
//            self?.timeLeft -= 1
//            if self?.timeLeft ?? 0 < 1 {
//                self?.timeIsUp = true
//                self?.counterLabel.text = "Vreme isteklo"
//            }
//            if self?.timeLeft ?? 0 > 0 && self?.timeIsUp == false {
//                self?.setTimers()
//            }
//        })
//        RunLoop.main.add(timer, forMode: .common)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(with startTime: Date, counterTime: Date, timeLeft: TimeInterval){
        self.startTimeLabel.text = StaticHelpers.dateTimeFormatterHHmm.string(from: startTime)
        if timeIsUp == false {
        self.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: counterTime)
        self.newTime = counterTime
        self.timeLeft = timeLeft
        } else {
            self.counterLabel.text = "Vreme isteklo"
            self.counterLabel.textColor = Colors.Basic.red
            self.timer.invalidate()
        }
        
//        let timeNow = Date()
//        timeLeft = startTime.timeIntervalSince1970 - timeNow.timeIntervalSince1970
//        newTime = Date(timeIntervalSince1970: (timeLeft))
//        if timeLeft < 1 {
//            timeIsUp = true
//        }
//        if timeLeft < 0 && timeIsUp == true {
//            self.counterLabel.textColor = Colors.Basic.red
//            self.counterLabel.text = "Vreme isteklo"
//        }
    }
    
    func setTimers(){
        if timeLeft > 0 {
            if self.timeLeft > 3599 {
                self.counterLabel.textColor = Colors.Basic.white
                self.counterLabel.text = StaticHelpers.dateTimeFormatterHHmmss.string(from: self.newTime)
            } else if self.timeLeft < 10 && self.timeLeft != 0{
                self.counterLabel.textColor = Colors.Basic.red
                self.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: self.newTime)
            } else {
                self.counterLabel.textColor = Colors.Basic.white
                self.counterLabel.text = StaticHelpers.dateTimeFormatterMMss.string(from: self.newTime)
            }
            } else {
//                self.timer.invalidate()
                self.counterLabel.text = "Vreme isteklo"
                self.timeIsUp = true
            }
    }
    
    func styleViews(){
        self.startTimeLabel.textColor = Colors.Basic.white
        self.counterLabel.textColor = Colors.Basic.white
        self.backgroundColor = Colors.Basic.black
        self.selectionStyle = .none
    }
}
