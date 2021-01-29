//
//  LiveDrawViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 29.1.21..
//

import UIKit
import WebKit

class LiveDrawViewController: UIViewController {

    @IBOutlet weak var drawWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Router.showDraw.fullUrl()
        let request = URLRequest(url: url)
        drawWebView.load(request)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
