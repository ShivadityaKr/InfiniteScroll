//
//  UIStoryboard+Navigation.swift
//  Pagnination fetch api
//
//  Created by Shivaditya Kumar on 16/02/22.
//

import Foundation
import UIKit

extension UIStoryboard {
    static let splash = UIStoryboard(name : "Splash", bundle: .main)
    static let page = UIStoryboard(name : "Page", bundle: .main)
    
    func instanceOf<T: UIViewController>(viewController: T.Type) ->T? {
        let x = String(describing: viewController.self)
        let vc = self.instantiateViewController(withIdentifier: x) as? T
        vc?.modalPresentationStyle = .fullScreen
        return vc
    }
    
    static func makeNavigationControllerAsRootVC( _ viewController: UIViewController) {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.setNavigationBarHidden(true, animated: false)
        navigation.modalPresentationStyle = .fullScreen
        AppDelegate.shared().window?.rootViewController = navigation
        AppDelegate.shared().window?.makeKeyAndVisible()
    }
}
extension UINavigationController {
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
}
