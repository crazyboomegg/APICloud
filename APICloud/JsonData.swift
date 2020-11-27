//
//  JsonData.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation


struct Photo : Decodable {
    let albumId : Int?
    let id : Int?
    let title : String?
    let url : String?
    let thumbnailUrl : String?
    
    enum CodingKeys: CodingKey {
        case albumId, id, title, url, thumbnailUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        albumId = try container.decodeIfPresent(Int.self, forKey: .albumId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        thumbnailUrl = try container.decodeIfPresent(String.self, forKey: .thumbnailUrl)
     
       }
}
