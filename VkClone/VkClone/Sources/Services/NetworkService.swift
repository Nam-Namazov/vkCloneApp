//
//  NetworkService.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getFeed() {
        var components = URLComponents()
        
        guard let token = authService.token else { return }
        let params = ["filters": "post,photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = allParams.map {
            URLQueryItem(name: $0, value: $1)
        }
        
        let url = components.url!
        print(url)
    }
}
