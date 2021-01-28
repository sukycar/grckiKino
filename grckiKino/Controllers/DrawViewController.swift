//
//  DrawViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import UIKit

class DrawViewController: UIViewController {

   
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    @IBOutlet weak var drawDetailsView: UIView!
    @IBOutlet weak var timeOfDrawLabel: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var drawIdLabel: UILabel!
    
    @IBOutlet weak var combinationsView: UIView!
    @IBOutlet var numberOfCombinationsCollection: [UILabel]!
    @IBOutlet var quotaCollection: [UILabel]!
    @IBOutlet var quotaTitlesCollection: [UILabel]!
    @IBOutlet weak var titlesHolderStackView: UIStackView!
    @IBOutlet weak var separatorView: UIView!
    

    @IBOutlet weak var selectionTopView: UIView!
    @IBOutlet weak var randomSelectionButton: UIButton!
    @IBOutlet weak var numbersTitleLabel: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    
    @IBOutlet weak var selectionCollectionView: UICollectionView!
    
    var draw: Draw?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        styleViews()
        selectionCollectionView.delegate = self
        selectionCollectionView.dataSource = self
        selectionCollectionView.register(for: NumberCollectionViewCell.cellIdentifier)
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
    }
    
    func styleViews(){
        self.view.backgroundColor = Colors.Basic.black

        // configure top collection view
        self.topCollectionView.backgroundColor = Colors.Selection.darkBlue
        
        // configure draw details view
        self.drawDetailsView.backgroundColor = Colors.Selection.gray
        timeOfDrawLabel.font = UIFont.systemFont(ofSize: 14)
        timeOfDrawLabel.textColor = Colors.Basic.white
        if let time = draw?.getTimeValue() {
            let timeString = StaticHelpers.dateTimeFormatterHHmm.string(from: time)
            timeOfDrawLabel.text = "Vreme izvlačenja: \(timeString)"
        }
        separatorLabel.font = UIFont.systemFont(ofSize: 14)
        separatorLabel.textColor = Colors.Basic.white
        separatorLabel.text = " | "
        drawIdLabel.font = UIFont.systemFont(ofSize: 14)
        drawIdLabel.textColor = Colors.Basic.white
        let drawId = String(draw?.drawId ?? 0)
        drawIdLabel.text = "Kolo: \(drawId)"
        
        
        // configure selection collection view
        self.selectionCollectionView.backgroundColor = Colors.Basic.black
        
        // configure combinations view
        self.combinationsView.backgroundColor = Colors.Selection.grayMedium
        numberOfCombinationsCollection.forEach { (label) in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = Colors.Basic.white
            switch label.tag {
            case 1:
                label.text = "1"
            case 2:
                label.text = "2"
            case 3:
                label.text = "3"
            case 4:
                label.text = "4"
            case 5:
                label.text = "5"
            case 6:
                label.text = "6"
            case 7:
                label.text = "7"
            default:
                return
            }
        }
        quotaCollection.forEach { (label) in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = Colors.Basic.white

            switch label.tag {
            case 8:
                label.text = "3.75"
            case 9:
                label.text = "14"
            case 10:
                label.text = "65"
            case 11:
                label.text = "275"
            case 12:
                label.text = "1350"
            case 13:
                label.text = "6500"
            case 14:
                label.text = "25000"
            default:
                return
            }
        }
        quotaTitlesCollection.forEach { (label) in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = Colors.Basic.white

            let tag = label.tag
            switch tag {
            case 15:
                label.text = "B.K."
            case 16:
                label.text = "Kvota"
            default:
                return
            }
        }
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Colors.Selection.gray
        separatorView.leadingAnchor.constraint(equalTo: titlesHolderStackView.trailingAnchor, constant: 5).isActive = true
        
        // configure selection collection top view
        selectionTopView.backgroundColor = Colors.Basic.black
        randomSelectionButton.setTitleColor(Colors.Basic.white, for: .normal)
        randomSelectionButton.setTitle("Slučajni odabir", for: .normal)
        randomSelectionButton.sizeToFit()
        randomSelectionButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        randomSelectionButton.backgroundColor = Colors.Selection.lightBlue
        randomSelectionButton.layer.cornerRadius = 3
        randomSelectionButton.clipsToBounds = true
        numbersTitleLabel.textColor = Colors.Basic.white
        numbersTitleLabel.font = UIFont.systemFont(ofSize: 14)
        numbersTitleLabel.text = "Brojevi:"
        numbersLabel.textColor = Colors.Basic.white
        numbersLabel.font = UIFont.systemFont(ofSize: 14)
        numbersLabel.text = "8"
    }

}

extension DrawViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectionCollectionView {
        return 80
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == selectionCollectionView {
        let cell = selectionCollectionView.dequeueReusableCell(withReuseIdentifier: NumberCollectionViewCell.cellIdentifier, for: indexPath) as! NumberCollectionViewCell
        cell.numberLabel.text = String(indexPath.row + 1)
        
        return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension DrawViewController {
    class func get(with draw: Draw) -> DrawViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let myViewController = storyBoard.instantiateViewController(withIdentifier: "DrawViewController") as! DrawViewController
        myViewController.draw = draw
        return myViewController
    }
}
