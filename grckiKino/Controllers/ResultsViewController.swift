//
//  ResultsViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//

import UIKit
import CoreData


class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    var context = DataManager.shared.context
    var resultsArray = [DrawResult]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.register(for: ResultsMainCollectionViewCell.cellIdentifier)
        resultsCollectionView.backgroundColor = Colors.Basic.black
        self.view.backgroundColor = Colors.Basic.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchResults()
    }
    
    func fetchResults(){
        let request = DrawResult.fetchRequest() as NSFetchRequest
        let sort = NSSortDescriptor(key: "drawId", ascending: true)
        request.sortDescriptors = [sort]
        do {
            resultsArray = try context?.fetch(request) as! [DrawResult]
        } catch {
            print("NOT FETCHED")
        }
        self.resultsCollectionView.reloadData()
    }
    

}

extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: ResultsMainCollectionViewCell.cellIdentifier, for: indexPath) as! ResultsMainCollectionViewCell
        let model = resultsArray[indexPath.row]
        cell.set(with: model)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.width / 1.5
        return CGSize(width: width, height: height)
    }

}
