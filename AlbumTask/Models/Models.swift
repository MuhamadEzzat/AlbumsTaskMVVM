//
//  _UserData.swift
//  AlbumTask
//
//  Created by Mohamed Ezzat on 27/04/2022.
//

import Foundation

//MARK: - User Data
struct _UserDara: Codable{
    var id: Int
    var name: String
    var address: _UserAddress
}
struct _UserAddress: Codable{
    var street: String
    var suite: String
    var city: String
    var zipcode: String
}

//MARK: - Album Data
struct _AlbumData: Codable{
    var userId: Int
    var id: Int
    var title: String
}
struct AlbumResponse: Decodable {
    let results: [_AlbumData]
}

//MARK: - Photo Data
struct _PhotoData: Codable{
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

