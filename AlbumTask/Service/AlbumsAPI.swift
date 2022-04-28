//
//  CarsAPI.swift
//  Cars
//
//  Created by Mohamed Ezzat on 20/02/2022.
//

import Foundation
import APIKit

final class AlbumsAPI {}

// MARK: API struct & Enums
extension AlbumsAPI {

    struct MakeRequest: AlbumsRequest {

        // MARK: - Initialize
//        let language: String
//        let page: Int
//
//        init(language: String = "Swift", page: Int) {
//            self.language = language
//            self.page = page
//        }

        // MARK: - Request Type
        let method: HTTPMethod = .get
        let path: String = "/vehicle/v3/makes"

        var parameters: Any? {
            var params = [String: Any]()
            params["api_key"] = "2ep93tpnyh6p5hgaxmp6pasq"
            return params
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [_AlbumData] {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            let res = try JSONDecoder().decode(AlbumResponse.self, from: data)
            return res.results
        }
    }

}

