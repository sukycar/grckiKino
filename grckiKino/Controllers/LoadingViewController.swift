//
//  LoadingViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 28.1.21..
//

import UIKit
import CoreData

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    private var timer = Timer()
    private let context = DataManager.shared.context
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteObjects()
        deleteResultObjects()
        styleViews()
        DrawService.getAll()
        DrawService.getDrawsByDate(withDates: "2021-01-29", toDate: "2021-01-29")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true)
        }
    }
    
    func styleViews(){
        self.imageView.image = UIImage(named: "img_mozzart")
        self.view.backgroundColor = Colors.Loading.blueBackground
        self.messageLabel.textColor = Colors.Loading.white
        self.messageLabel.text = "Molimo Vas da sacekate \n dok se ucitaju podaci"
    }
    
    func deleteObjects(){
        let fetchRequest = Draw.fetchRequest() as NSFetchRequest
        let objects = try! context?.fetch(fetchRequest)
        objects?.forEach({ (draw) in
            context?.delete(draw)
        })
        try! context?.save()
    }
    
    func deleteResultObjects(){
        let fetchRequest = DrawResult.fetchRequest() as NSFetchRequest
        let objects = try! context?.fetch(fetchRequest)
        objects?.forEach({ (draw) in
            context?.delete(draw)
        })
        try! context?.save()
    }
    
}
