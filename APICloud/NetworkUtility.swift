//
//  NetworkUtility.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation
import UIKit

struct NetworkUtility {
    
    static func downloadImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                handler(image)
            } else {
                handler(nil)
            }
        }
        task.resume()
        
    }
    
}
