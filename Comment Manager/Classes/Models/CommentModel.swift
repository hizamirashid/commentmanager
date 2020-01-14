//
//  CommentModel.swift
//  Comment Manager
//
//  Created by Hizami Rashid on 14/01/2020.
//  Copyright © 2020 Hizami Rashid. All rights reserved.
//

import Foundation

struct CommentModel : Codable {
    let postId : Int?
    let id : Int?
    let name : String?
    let email : String?
    let body : String?
    
    enum CodingKeys: String, CodingKey {
        
        case postId = "postId"
        case id = "id"
        case name = "name"
        case email = "email"
        case body = "body"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postId = try values.decodeIfPresent(Int.self, forKey: .postId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
    
}
