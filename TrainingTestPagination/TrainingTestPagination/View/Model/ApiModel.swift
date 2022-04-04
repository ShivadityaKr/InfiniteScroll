//
//  APIModel.swift
//  TrainingTestPagination
//
//  Created by Shivaditya Kumar on 02/04/22.
//

import Foundation
struct ResponseElement: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    private enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
typealias Response = [ResponseElement]
