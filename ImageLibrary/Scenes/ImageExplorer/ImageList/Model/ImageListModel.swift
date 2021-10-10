//
//  ImageListModel.swift
//  ImageLibrary
//
//  Created by AhmedFitoh on 10/10/21.
//

import Foundation

typealias ImageList = [ImageListElement]

// MARK: - ImageListElement
struct ImageListElement: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}


extension ImageListElement: ImageListCellUIProtocol{
    var authorName: String? { author }
    var imageUrl: String? { downloadURL }
}

