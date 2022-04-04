//
//  PageCVC.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit

class PageCVC: UITableViewCell {
    @IBOutlet weak var sampleImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var chooseOneLabel : UILabel!
    static var identifier = LocalizableStrings.TableCell.identifier.localised
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {
        setImageView()
        setNameLabel()
        setChooseOneLabel()
    }
    private func setImageView() {
        self.sampleImageView.image = UIImage(named: LocalizableStrings.TableCell.imageName.localised)
        self.sampleImageView.layer.cornerRadius = 5
    }
    private func setNameLabel() {
        self.nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.nameLabel.textColor = .black
    }
    private func setChooseOneLabel() {
        self.chooseOneLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        self.chooseOneLabel.textColor = .darkGray
        self.chooseOneLabel.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    var pageData : ResponseElement!
    func hideChooseOneLabel() {
        chooseOneLabel.isHidden = true
    }
    func unhideChooseOneLabel() {
        chooseOneLabel.isHidden = false
    }
    private let imageCache = NSCache<AnyObject, UIImage>()
    func setData(data : ResponseElement, _ index : Int) {
        if sampleImageView.image == nil{
            self.sampleImageView.image = UIImage(named: LocalizableStrings.TableCell.imageName.localised)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.pageData = data
            self.nameLabel.text = data.author
            self.chooseOneLabel.text = "\(LocalizableStrings.TableCell.chooseOneLabel.localised) \(index)"
            self.sampleImageView.loadImageCacheWithUrlString(urlString: data.downloadURL)
        }
    }
}
