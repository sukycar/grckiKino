//
//  API.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import Foundation
import UIKit

class API: NSObject {
    static let shared = API()
    
    func request(router:Router, parameters:[String : AnyObject]?, completion:@escaping ((URLResponse) -> Void)) -> URLRequest {
        let url = router.fullUrl()
        var request = URLRequest(url: url)
        request.httpMethod = router.httpMethod
        return request
    }
    
    
}


