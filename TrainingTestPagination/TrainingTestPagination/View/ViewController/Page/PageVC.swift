//
//  PageVC.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit
protocol PageView : UIViewController {
    var tableView : UITableView! {get}
}
class PageVC: UIViewController, PageView {
    @IBOutlet weak var tableView : UITableView!
    var viewModel : PageVM!
    var uiVc : PageUIVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.view = self
        self.uiVc.view = self
    }
    class func instantiate() -> PageVC {
        let vc = UIStoryboard.page.instanceOf(viewController: PageVC.self)!
        vc.viewModel = PageVM()
        vc.uiVc = PageUIVC()
        return vc
    }
}
extension PageVC : UITableViewDelegate {
}
