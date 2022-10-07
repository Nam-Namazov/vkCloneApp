//
//  UserResponse.swift
//  VkClone
//
//  Created by Намик on 10/7/22.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
