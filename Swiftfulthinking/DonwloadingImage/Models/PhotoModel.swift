//
//  PhotoModel.swift
//  Swiftfulthinking
//
//  Created by Raden Dimas on 27/10/21.
//

import Foundation

struct PhotoModel: Identifiable,Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String

}
