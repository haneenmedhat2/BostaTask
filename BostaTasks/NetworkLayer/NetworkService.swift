//
//  NetworkService.swift
//  BostaTasks
//
//  Created by Haneen Medhat on 28/11/2024.
//

import Foundation
import Moya

enum NetwrokService {
    case getUser
    case getUserAlbums(userId:Int)
}

extension NetwrokService : TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else { fatalError("Invalid URL") }
        return url
    }

    var path: String {
        switch self {
        case .getUser :
            return "/users"
        case .getUserAlbums(userId: let userId):
            return "/albums"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
