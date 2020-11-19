//
//  JsonData.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation


struct Photo : Decodable {
    let albumId : Int
    let id : Int
    let title : String
    let url : String
    let thumbnailUrl : String
}
