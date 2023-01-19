//
//  Token.swift
//  Kaohsiung MRT Navi
//
//  Created by Yang Tun-Kai on 2023/1/13.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
       
    private enum CodingKeys : String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}
