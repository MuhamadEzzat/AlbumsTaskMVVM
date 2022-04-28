//
//  apiManager.swift
//  Created by Mohamed Ezzat on 27/04/2022.
//
//
//

import UIKit
import Foundation
import Alamofire

class APIManager {
    
    //MARK: - Singlton
    class var sharedInstance : APIManager {
        struct Singlton {
            static let instance = APIManager()
        }
        return Singlton.instance
    }
    
    var header : [String: String]? = [:]
    
    // MARK: - general request
   
    func getRequest(_ url : String ,completionHandler :@escaping (AFDataResponse<Any>) -> Void) {
        _ = AF.request(url,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            completionHandler(response)
        }
    }
    
}
        

        
  
    


