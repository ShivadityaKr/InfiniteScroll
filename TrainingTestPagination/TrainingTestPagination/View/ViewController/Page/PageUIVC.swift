//
//  PageUIVC.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import UIKit

class PageUIVC : NSObject {
    var view : PageView? {
        didSet {
            setupUI()
        }
    }
    private func setupUI() {
        
    }
}
