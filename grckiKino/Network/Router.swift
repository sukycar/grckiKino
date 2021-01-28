//
//  Router.swift
//  grckiKino
//
//  Created by Vladimir Sukanica on 27.1.21..
//

import Foundation

enum Router {
    case getDataForGame(gameId: Int)
    case getDraw(gameId: Int, drawId: Int)
    case showDraw

    private var baseURL: String {
        return "https://api.opap.gr/draws/v3.0/"
    }
    
    var path: String {
        switch self {
        case .getDataForGame(let id):
            return "\(id)/upcoming/20"
        case .showDraw:
            return "https://ds.opap.gr/web_kino/kinoIframe.html?link=https://ds.opap.gr/web_kino/kino/html/Internet_PRODUCTION/KinoDraw_201910.html&resolution=847x500"
        case .getDraw(let gameId, let drawId):
            return "\(gameId)/\(drawId)"
        }
    }
    
    func fullUrl() -> URL{
        switch self {
        case .getDataForGame:
            return URL(string: self.baseURL + self.path)!
        case .showDraw:
            return URL(string: path)!
        case .getDraw:
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



