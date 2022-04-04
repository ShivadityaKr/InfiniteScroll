//
//  String.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 04/04/22.
//

import Foundation
extension String {
    var localised: String {
        return NSLocalizedString(self, comment: self)
    }
}
