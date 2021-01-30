//
//  ResultsViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 30.1.21..
//

import UIKit
import CoreData


class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!
    
    var context = DataManager.shared.context
    var resultsArray : [DrawResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(for: ResultsTableViewCell.cellIdentifier)
        fetchResults()
        resultsTableView.backgroundColor = Colors.Basic.black
        self.view.backgroundColor = Colors.Basic.black
        
    }
    
    func fetchResults(){
        let request = DrawResult.fetchRequest() as NSFetchRequest
        let sort = NSSortDescriptor(key: "drawId", ascending: false)
        request.sortDescriptors = [sort]
        do {
            resultsArray = try context?.fetch(request)
            self.resultsTableView.reloadData()
        } catch {
            print("NOT FETCHED")
        }
    }

}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.cellIdentifier, for: indexPath) as! ResultsTableViewCell
        if let model = resultsArray?[indexPath.row] {
        cell.set(with: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width / 1.5
    }
    
    
    
}
