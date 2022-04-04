//
//  LocalizableStrings.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 04/04/22.
//

import Foundation
class LocalizableStrings {
    enum TableCell : String {
        case identifier = "PageCVC/identifier"
        case imageName = "PageCVC/imageName"
        case chooseOneLabel = "PageCVC/chooseOneLabel/text"
        var localised : String {
            return self.rawValue.localised
        }
    }
    enum PageDetail : String {
        case backButtonTitle = "PageDetailVC/backButton/title"
        case backButtonImageName = "PageDetailVC/backButton/imageName"
        case authorNameLabel = "PageDetailVC/authorNameLabel/text"
        var localised : String {
            return self.rawValue.localised
        }
    }
    enum Page : String {
        case method = "Page/method"
        var localised : String {
            return self.rawValue.localised
        }
    }
}
