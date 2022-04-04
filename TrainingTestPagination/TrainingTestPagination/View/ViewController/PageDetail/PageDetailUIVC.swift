//
//  PageDetailUIVC.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 04/04/22.
//

import UIKit

class PageDetailUIVC : NSObject {
    var view : PageDetailView? {
        didSet {
            setupUI()
        }
    }
    var viewModel : PageDataSource? {
        didSet {
            setData()
        }
    }
    @objc func didBackButtonTap() {
        view?.dismiss(animated: true, completion: nil)
    }
    private func setupUI(){
        setBackButton()
        setNameLabel()
        setImageView()
    }
    private func setBackButton() {
        view?.backButton.backgroundColor = .systemTeal
        view?.backButton.setTitle(LocalizableStrings.PageDetail.backButtonTitle.localised, for: .normal)
        if #available(iOS 13.0, *) {
            view?.backButton.setImage(UIImage(systemName: LocalizableStrings.PageDetail.backButtonImageName.localised), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        view?.backButton.tintColor = .white
        view?.backButton.addTarget(self, action: #selector(didBackButtonTap), for: .touchUpInside)
    }
    private func setNameLabel() {
        view?.authorNameLabel.textColor = .black
        view?.authorNameLabel.text = LocalizableStrings.PageDetail.authorNameLabel.localised
        view?.authorNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    private func setImageView() {
        view?.detailImageView.image = UIImage(named: LocalizableStrings.TableCell.imageName.localised)
        view?.detailImageView.layer.cornerRadius = 5
    }
    private func setData() {
        view?.authorNameLabel.text = viewModel?.dataSource.author
        view?.detailImageView.loadImageCacheWithUrlString(urlString: (viewModel?.dataSource!.downloadURL)!)
    }
}
