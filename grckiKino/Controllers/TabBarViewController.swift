//
//  TabBarViewController.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 29.1.21..
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    enum TabBarIcon:Int {
        case talon = 0, liveDraw = 1, results = 2
        
        var name:String {
            switch self {
            case .talon:
                return "Talon"
            case .liveDraw:
                return "Izvlačenje uživo "
            case .results:
                return "Rezultati izvlačenja"
            }
        }
        var image: UIImage? {
            switch self {
            case .talon:
                return UIImage(named: "img_talon")
            case .results:
                return UIImage(named: "img_rezultati")
            case .liveDraw:
                return UIImage(named: "img_izvlacenje")
            }
        }
        
        
        static let icons = [talon, liveDraw, results]
    }

    var draw : Draw?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureIcons()
        self.tabBar.barTintColor = Colors.Selection.darkBlue
        self.tabBar.isTranslucent = false
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabViewControllers = tabBarController.viewControllers
        let fromView = tabBarController.selectedViewController?.view
        let toView = viewController.view

        if (fromView == toView) {
            return false
        }
        if let fromView = fromView, let toView = toView, let selectedViewController = tabBarController.selectedViewController, let fromIndex = tabViewControllers?.firstIndex(of: selectedViewController), let toIndex = tabViewControllers?.firstIndex(of: viewController) {
            let offScreenRight = CGAffineTransform(translationX: toView.frame.width, y: 0)
            let offScreenLeft = CGAffineTransform(translationX: -toView.frame.width, y: 0)

            // start the toView to the right of the screen
            if (toIndex < fromIndex) {
                toView.transform = offScreenLeft
                fromView.transform = offScreenRight
            } else {
                toView.transform = offScreenRight
                fromView.transform = offScreenLeft
            }

            fromView.tag = 124
            toView.addSubview(fromView)
            let oldClipsToBounds = toView.clipsToBounds
            toView.clipsToBounds = false
            self.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
//                fromView.transform = .identity
                if (toIndex < fromIndex) {
                    toView.transform = offScreenLeft
                    fromView.transform = offScreenRight
                } else {
                    toView.transform = offScreenRight
                    fromView.transform = offScreenLeft
                }
                toView.transform = CGAffineTransform.identity

            }, completion: { finished in
                toView.clipsToBounds = oldClipsToBounds
                let subViews = toView.subviews
                for subview in subViews{
                    if (subview.tag == 124) {
                        subview.removeFromSuperview()
                    }
                }
                viewController.view.layoutIfNeeded()
                tabBarController.selectedIndex = toIndex
                self.view.isUserInteractionEnabled = true

            })
        }

        return true
    }
    
    private func configureIcons(){
        for icon in TabBarIcon.icons.enumerated() {
            self.tabBar.items?[icon.offset].title = icon.element.name
            self.tabBar.items?[icon.offset].image = icon.element.image?.withRenderingMode(.alwaysTemplate)
            self.tabBar.items?[icon.offset].selectedImage = icon.element.image?.withRenderingMode(.alwaysTemplate)
        }
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

extension TabBarViewController {
    class func get(with draw: Draw) -> TabBarViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        tabBarController.draw = draw
        return tabBarController
    }
}
