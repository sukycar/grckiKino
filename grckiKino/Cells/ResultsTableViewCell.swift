//
//  ResultsTableViewCell.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    var draw : DrawResult? {
        didSet{
            self.numbers = draw?.getDrawNumbers()
        }
    }
    var numbers : [Int]?
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        configureCollectionView()
        self.frame.size.height = resultsCollectionView.contentSize.height
        self.backgroundColor = Colors.Basic.black
    }

    func configureCollectionView(){
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.minimumLineSpacing = 2
        collectionLayout.minimumInteritemSpacing = 2
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15)
        collectionLayout.scrollDirection = .vertical
        resultsCollectionView.collectionViewLayout = collectionLayout
        resultsCollectionView.register(for: ResultsCollectionViewCell.cellIdentifier)
        resultsCollectionView.backgroundColor = Colors.Basic.black
        resultsCollectionView.registerHeaderView(for: ResultHeaderView.reusableViewIdentifier)
        resultsCollectionView.isScrollEnabled = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(with draw: DrawResult?){
        self.draw = draw
    }
    
    
    
}

extension ResultsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: ResultsCollectionViewCell.cellIdentifier, for: indexPath) as! ResultsCollectionViewCell
        if let model = numbers?[indexPath.row] {
        cell.set(with: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 8
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = resultsCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: ResultHeaderView.reusableViewIdentifier, for: indexPath) as! ResultHeaderView
        headerView.set(with: draw)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = resultsCollectionView.frame.width
        return CGSize(width: width, height: 40)
    }
    
    
}
