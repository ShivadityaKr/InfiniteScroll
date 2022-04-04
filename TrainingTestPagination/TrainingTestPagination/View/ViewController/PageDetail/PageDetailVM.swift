//
//  PageDetailVM.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 04/04/22.
//

import UIKit
protocol PageDataSource : AnyObject {
    var dataSource : ResponseElement! {get}
}
class PageDetailVM : NSObject, PageDataSource {
    var dataSource: ResponseElement!
    var viewModel : PageDetailViewModel? {
        didSet {
            fetchData(pageDetail: (viewModel?.detail)!)
        }
    }
    var fetchAPI = RestManager()
    func fetchData(pageDetail : ResponseElement) {
        let id = pageDetail.id
        let baseURL = "https://picsum.photos/id/\(id)/info"
        let url = URL(string: baseURL)!
        fetchAPI.fetchData(for: url) { (result: Result<ResponseElement, Error>) in
            switch result {
            case .success(let response):
                self.dataSource = response
                DispatchQueue.main.async {
                    self.viewModel?.uiVc.viewModel = self
                }
                break
              
            case .failure(let error):
                print(error)
                break
              
          }
        }
    }
}
