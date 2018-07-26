//
//  Models.swift
//  App
//
//  Created by Jared Sorge on 6/11/18.
//

import Foundation
import Vapor

public struct MicropubBlogPostRequest: Codable {
    public let h: String
    public let name: String?
    public let content: String
    public let date = Date()
    public let photo: String?
    public let category: [String]?
    
    enum CodingKeys: String, CodingKey {
        case h
        case name
        case content
        case photo
        case category
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.h = try container.decode(String.self, forKey: .h)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.content = try container.decode(String.self, forKey: .content)
        self.photo = try container.decodeIfPresent(String.self, forKey: .photo)
        
        if let category = try container.decodeIfPresent(String.self, forKey: .category) {
            self.category = [category]
        }
        else if let categories = try container.decodeIfPresent([String].self, forKey: .category) {
            self.category = categories
        }
        else {
            self.category = nil
        }
    }
}

struct MediaUpload: Content {
    let file: File?
}

struct Auth: Codable {
    let me: String
    let redirectURI: String
    let clientID: String
    let scope: String?
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.me = try container.decode(String.self, forKey: .me)
        self.redirectURI = try container.decode(String.self, forKey: .redirectURI)
        self.clientID = try container.decode(String.self, forKey: .clientID)
        self.scope = try container.decodeIfPresent(String.self, forKey: .scope)
        self.authCode = try container.decodeIfPresent(String.self, forKey: .authCode)
        
        var state: String? = nil
        if let stateStr = try container.decodeIfPresent(String.self, forKey: .state) {
            state = stateStr
        }
        else if let stateInt = try container.decodeIfPresent(Int.self, forKey: .state) {
            state = "\(stateInt)"
        }
        self.state = state
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

    let me: String
    let clientID: String
    let authCode: String
    var authToken: Token?
}

struct TokenOutput: Codable {
    let accessToken: String
    let scope: String?
    let me: String

    var urlEncodedString: String {
        let token = URLQueryItem(name: "access_token", value: self.accessToken)
        let me = URLQueryItem(name: "me", value: self.me.urlEncoded())

        var components = URLComponents()
        components.queryItems = [token, me]
        if self.scope != nil {
            let scope = URLQueryItem(name: "scope", value: self.scope)
            components.queryItems!.append(scope)
        }

        return components.query!
    }

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case scope
        case me
    }
}
