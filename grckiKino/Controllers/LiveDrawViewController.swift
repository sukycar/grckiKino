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
    }
    
}
