//
//  PageVM.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit

class PageVM : NSObject {
    var view : PageView? {
        didSet {
            setupData()
        }
    }
    var listNumber = 10
    var totalPage : [ResponseElement] = []
    var pageList : [ResponseElement] = []
    var isPaginationOn = false
    var page = 1
    var timer : Timer?
    var counter = 0
    let fetchAPI = RestManager()
    private func setupData() {
        self.view?.tableView.reloadData()
        self.view?.tableView.dataSource = self
        self.view?.tableView.estimatedRowHeight = 100
        self.view?.tableView.register(UINib(nibName: PageCVC.identifier, bundle: nil), forCellReuseIdentifier: PageCVC.identifier)
        self.view?.tableView.delegate = self
        getDataList(page: 0, limit: listNumber)
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prosessTimer), userInfo: nil, repeats: true)
    }
    func getDataList(page: Int, limit: Int) {
        let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)")!
          fetchAPI.fetchData(for: url) { (result: Result<[ResponseElement], Error>) in
            switch result {
            case .success(let response):
                self.pageList = response
                
                
                DispatchQueue.main.async {
                    let prevCount = self.totalPage.count
                    self.totalPage.append(contentsOf: self.pageList)
                    self.view?.tableView.beginUpdates()
                    let startIndex = prevCount
                    let endIndex = self.totalPage.count - 1
                    var indexPaths = [IndexPath]()
                    for i in startIndex...endIndex {
                        indexPaths.append(IndexPath(row: i, section: 0))
                    }
                    self.view?.tableView.insertRows(at: indexPaths, with: .automatic)
                    self.view?.tableView.endUpdates()
                }
                break
            case .failure(let error):
                print(error)
                break
              
          }
        }
    }
  
}
extension PageVM : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalPage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PageCVC.identifier) as? PageCVC else {return UITableViewCell()}
        guard totalPage.indices.contains(indexPath.row) else { return cell }
        let page = totalPage[indexPath.row]
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            cell.setData(data: page, indexPath.row + 1)
        }
        return cell
    }
}
extension PageVM : UITableViewDelegate, UIScrollViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PageCVC else {return}
        let vc = PageDetailVC.instantiate()
        DispatchQueue.global().async {
            vc.getData(pageDetail: cell.pageData)
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        view?.present(nav, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == totalPage.count - 2 {
            self.page += 1
            self.getDataList(page: self.page, limit: listNumber)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let visiblCell = self.view?.tableView.indexPathsForVisibleRows
        visiblCell?.forEach({ indexPath in
            guard let cell = self.view?.tableView.cellForRow(at: indexPath) as? PageCVC else {return}
            cell.hideChooseOneLabel()
        })
        timer?.invalidate()
        timer = nil
        counter = 0
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(prosessTimer), userInfo: nil, repeats: true)
            
    }
    @objc func prosessTimer() {
        counter += 1
        if counter > 5 {
            let visiblCell = self.view?.tableView.indexPathsForVisibleRows
            visiblCell?.forEach({ indexPath in
                if indexPath ==  visiblCell?.last {
                    guard let cell = self.view?.tableView.cellForRow(at: indexPath) as? PageCVC else {return}
                    cell.unhideChooseOneLabel()
                    guard let secondCell = self.view?.tableView.cellForRow(at: [0,indexPath.row - 1]) as? PageCVC else {return}
                    secondCell.unhideChooseOneLabel()
                } else {
                    guard let cell = self.view?.tableView.cellForRow(at: indexPath) as? PageCVC else {return}
                    cell.hideChooseOneLabel()
                }
            })
        }
    }
}
