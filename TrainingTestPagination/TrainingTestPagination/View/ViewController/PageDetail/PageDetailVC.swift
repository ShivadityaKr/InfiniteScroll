//
//  PageDetailVC.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit
protocol PageDetailView : UIViewController {
    var backButton : UIButton! {get}
    var detailImageView : UIImageView! {get}
    var authorNameLabel : UILabel! {get}
    var detail : ResponseElement! {get}
}
protocol PageDetailViewModel : AnyObject {
    var detail : ResponseElement! {get}
    var uiVc : PageDetailUIVC! {get}
}
class PageDetailVC: UIViewController, PageDetailView, PageDetailViewModel {
    @IBOutlet weak var backButton : UIButton!
    @IBOutlet weak var detailImageView : UIImageView!
    @IBOutlet weak var authorNameLabel : UILabel!
    var uiVc : PageDetailUIVC!
    var viewModel : PageDetailVM!
    var detail : ResponseElement!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiVc.view = self
    }
   
    func getData(pageDetail : ResponseElement){
        detail = pageDetail
        self.viewModel.viewModel = self
    }
    class func instantiate() -> PageDetailVC {
        let vc = UIStoryboard.page.instanceOf(viewController: PageDetailVC.self)!
        vc.uiVc = PageDetailUIVC()
        vc.viewModel = PageDetailVM()
        return vc
    }

}
