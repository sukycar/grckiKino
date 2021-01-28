//
//  ViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var drawTimeTableView: UITableView!
    private let headerHolderView = UIView()
    private let imageView = UIImageView()
    private let separatorView = UIView()
    private let titleLabel = UILabel()
    private let headerLabelsStackView = UIStackView()
    private let timeOfDrawLabel = UILabel()
    private let timeLeftLabel = UILabel()
    private let timer = Timer()
    var drawsArray : [Draw]?
    var context = DataManager.shared.context
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTable()
        self.view.backgroundColor = Colors.Basic.black
        DrawService.getAll()
        fetchDraws()
    }
    
    func configureTable(){
        drawTimeTableView.delegate = self
        drawTimeTableView.dataSource = self
        drawTimeTableView.register(for: TimeTableViewCell.cellIdentifier)
        drawTimeTableView.tableFooterView = UIView()
        drawTimeTableView.separatorColor = Colors.Basic.gray
        drawTimeTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        drawTimeTableView.backgroundColor = Colors.Basic.black
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = drawTimeTableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.cellIdentifier, for: indexPath) as! TimeTableViewCell
        if let model = drawsArray?[indexPath.row] {
            let timeNow = Date()
            let timeLeft = model.getTimeValue().timeIntervalSince1970 - timeNow.timeIntervalSince1970
            let newTime = Date(timeIntervalSince1970: (timeLeft))
            cell.set(with: model.getTimeValue(), counterTime: newTime, timeLeft: timeLeft)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = drawsArray?[indexPath.row] {
        let vc = DrawViewController.get(with: item)
        self.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = Colors.Basic.black
        
        // add holder for elements in header
        headerView.addSubview(headerHolderView)
        headerHolderView.translatesAutoresizingMaskIntoConstraints = false
        headerHolderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5).isActive = true
        headerHolderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -5).isActive = true
        headerHolderView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5).isActive = true
        headerHolderView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        headerHolderView.backgroundColor = Colors.Basic.gray
        
        // add imageView to header
        headerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        imageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.image = UIImage(named: "img_greek_flag")
        
        // add label next to image
        headerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 20).isActive = true
        titleLabel.textColor = Colors.Basic.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = "Grčki kino (15/80)".uppercased()
        
        // add separator view to header
        headerView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        separatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 20).isActive = true
        separatorView.backgroundColor = Colors.Basic.darkBlue
        
        // add stack view with labels to header
        headerView.addSubview(headerLabelsStackView)
        headerLabelsStackView.translatesAutoresizingMaskIntoConstraints = false
        headerLabelsStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        headerLabelsStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        headerLabelsStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 15).isActive = true
        headerLabelsStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 20).isActive = true
        
        timeOfDrawLabel.text = "Vreme izvlačenja"
        timeOfDrawLabel.textColor = Colors.Basic.white
        timeOfDrawLabel.font = UIFont.systemFont(ofSize: 14)
        
        timeLeftLabel.text = "Preostalo za uplatu"
        timeLeftLabel.textColor = Colors.Basic.white
        timeLeftLabel.font = UIFont.systemFont(ofSize: 14)
        timeLeftLabel.textAlignment = .right
        
        headerLabelsStackView.addArrangedSubview(timeOfDrawLabel)
        headerLabelsStackView.addArrangedSubview(timeLeftLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    
}

extension ViewController {
    func fetchDraws(){
        let fetchRequest = Draw.fetchRequest() as NSFetchRequest
        let sort = NSSortDescriptor(key: "drawTime", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do {
            drawsArray = try context?.fetch(fetchRequest)
        } catch {
            print("NOT FETCHED")
        }
        self.drawTimeTableView.reloadData()
    }
}

