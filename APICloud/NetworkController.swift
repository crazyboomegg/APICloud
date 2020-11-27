//
//  NetworkController.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/25.
//

import Foundation
import UIKit


class NetworkController {

    
    static let imageCache = NSCache<NSURL, UIImage>()
    
    static func fetchImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        // 如果有暫存圖片就返回圖片
        if let image = imageCache.object(forKey: url as NSURL) {
            print("有暫存圖片, 返回!")
            handler(image)
            return
        }
        
        // 下載圖片
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                print("沒有暫存圖片, 下載!")
                self.imageCache.setObject(image, forKey: url as NSURL)
                handler(image)
            } else {
                handler(nil)
            }
        }
        task.resume()
    }
}
