//
//  SplashVC.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreen()
    }
    func loadScreen(){
        let vc = PageVC.instantiate()
        AppDelegate.shared().window?.rootViewController = vc
        AppDelegate.shared().window?.makeKeyAndVisible()
    }
}
