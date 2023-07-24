//
//  EndPoint.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import Foundation

enum Endpoint : String {
    
    var baseUrl : String {
        return Environment.test.rawValue
    }
  
    var url : String {
        return self.baseUrl + self.rawValue
    }
    
    // GET Requests
    case getPlayersList = "api/sc/players"
    
    // POST Requests
    case playerDetails = "api/sc/player/details"
    
}

enum Environment : String {
    
    case test = "https://ios.app99877.com/"
    
}
