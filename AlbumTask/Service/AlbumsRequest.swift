//
//  CarsRequest.swift
//  Cars
//
//  Created by Mohamed Ezzat on 20/02/2022.
//

import Foundation
import APIKit

protocol AlbumsRequest: Request {}

extension AlbumsRequest {
    var baseURL: URL {
        return URL(string: "https://api.edmunds.com/api")!
    }
}

extension AlbumsRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        switch urlResponse.statusCode {
        case 200..<300:
            return object
        default:
            throw NSError(domain: "Bad Status Response", code: urlResponse.statusCode, userInfo: nil)
        }
    }
}

struct DecodableDataParser: DataParser {
    let contentType: String? = "application/json"

    func parse(data: Data) throws -> Any {
        return data
    }
}

extension AlbumsRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
