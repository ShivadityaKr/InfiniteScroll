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
            getData(pageDetail: (viewModel?.detail)!)
        }
    }
    func getData(pageDetail : ResponseElement){
        let id = pageDetail.id
        let baseURL = "https://picsum.photos/id/\(id)/info"
        let url = URL(string: baseURL)
        guard let requestURL = url else{return}
        var request = URLRequest(url: requestURL)
        request.httpMethod = LocalizableStrings.Page.method.localised
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            return
        }
        var result: ResponseElement?
        do {
            result = try JSONDecoder().decode(ResponseElement.self, from: data)
        }
        catch {
            print(error)
        }
        guard let output = result else { return }
            self.dataSource = output
        DispatchQueue.main.async {
            self.viewModel?.uiVc.viewModel = self
        }
        }
        dataTask.resume()
    }
}
