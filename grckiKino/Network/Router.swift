//
//  Router.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import Foundation

enum Router {
    case getData(gameId: Int)

    private var baseURL: String {
        return "https://api.opap.gr/draws/v3.0/"
    }
    
    var path: String {
        switch self {
        case .getData(let id):
            return "\(id)/upcoming/20"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getData:
            return ".get"
        }
    }
    
    func fullUrl() -> URL{
        switch self {
        case .getData:
            return URL(string: self.baseURL + self.path)!
        }
        
    }
}

enum GameType: Int {
    case grckiKino = 1100
    
    var title: String {
        switch self {
        case .grckiKino:
            return "Grčki Kino"
        }
    }
}



