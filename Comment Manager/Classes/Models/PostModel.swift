//
//  PostModel.swift
//  Comment Manager
//
//  Created by Hizami Rashid on 14/01/2020.
//  Copyright © 2020 Hizami Rashid. All rights reserved.
//

import Foundation

struct PostModel : Codable {
    let userId : Int?
    let id : Int?
    let title : String?
    let body : String?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "userId"
        case id = "id"
        case title = "title"
        case body = "body"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        body = try values.decodeIfPresent(String.self, forKey: .body)
    }
    
}
