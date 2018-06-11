//
//  Models.swift
//  App
//
//  Created by Jared Sorge on 6/11/18.
//

import Foundation

public struct MicropubBlogPostRequest: Codable {
    public let h: String
    public let name: String?
    public let content: String
    public let date = Date()
}

struct Auth: Codable {
    let me: String
    let redirectURI: String
    let clientID: String
    let scope: String
    let authCode: String?
    let state: String?

    enum CodingKeys: String, CodingKey {
        case me
        case redirectURI = "redirect_uri"
        case clientID = "client_id"
        case scope
        case authCode = "code"
        case state
    }
}

struct AuthedService: Codable {
    struct Token: Codable {
        let value: String
        let date: Date

        static func new() -> Token {
            return Token(value: UUID().base64Encoded, date: Date())
        }
    }

    let clientID: String
    let authCode: String
    var authToken: Token?
}

struct TokenOutput: Codable {
    let accessToken: String
    let scope: String?
    let me: String
}
