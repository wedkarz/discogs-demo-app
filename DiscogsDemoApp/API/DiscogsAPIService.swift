//
//  DiscogsAPI.swift
//  DiscogsDemoApp
//
//  Created by Artur Rybak
//  Copyright © 2022 IT ART - Artur Rybak. All rights reserved.
//

import Foundation
import Moya

enum DiscogsServiceConstants {
    enum Artist: Int {
        case theDoors = 56798
    }
}

enum DiscogsAPIService {
    case artistReleases(id: DiscogsServiceConstants.Artist)
}

extension DiscogsAPIService: TargetType {
    var baseURL: URL { URL(string: "https://api.discogs.com")! }
    private var environment: AppEnvironment { .init() }
    
    var path: String {
        switch self {
        case .artistReleases(let id):
            return "/artists/\(id.rawValue)/releases"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .artistReleases:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .artistReleases:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-type": "application/json"]
        
        if let authHeader = authHeader {
            headers["Authorization"] = authHeader
        }
        
        return headers
    }
    
    private var authHeader: String? {
        guard let authKey = environment.discogsAuthKey, let authSecret = environment.discogsAuthSecret else { return nil }
        
        return "Discogs key=\(authKey), secret=\(authSecret)"
    }
}

struct AppEnvironment {
    let discogsAuthKey: String?
    let discogsAuthSecret: String?
    
    init(processInfo: ProcessInfo = ProcessInfo()) {
        self.discogsAuthKey = Bundle.main.object(forInfoDictionaryKey: Keys.discogsAuthKey.rawValue) as? String
        self.discogsAuthSecret = Bundle.main.object(forInfoDictionaryKey: Keys.discogsAuthSecret.rawValue) as? String
    }
    
    private enum Keys: String {
        case discogsAuthKey = "DISCOGS_AUTH_KEY"
        case discogsAuthSecret = "DISCOGS_AUTH_SECRET"
    }
}
