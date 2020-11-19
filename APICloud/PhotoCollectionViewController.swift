//
//  PhotoViewController.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation
import UIKit


class PhotoCollectionViewController: UICollectionViewController {
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("collectionview 讀取成功")
        

        
        fetchJson()
    }
    
    func fetchJson() {
        print("fetch")
    
        let apiUrl = "https://jsonplaceholder.typicode.com/photos"

        

        if let url = URL (string: apiUrl ) {
           print("url")
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let jsonData = try? JSONDecoder().decode([Photo].self, from: data) {
                    
                    print("url:: " + apiUrl)
                    print("data:: ", jsonData.count)
                    
                    self.photos = jsonData
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionview_return_count:: ")
        print(photos.count)
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PHOTO_CELL", for: indexPath) as! PhotoCollectionViewCell

        let photo = photos[indexPath.item]


        var imageUrl = URL(string: photo.url)

        cell.title.text = photo.title
        cell.id.text = String (photo.id)
        cell.imageURL = imageUrl
        cell.photoImage.image = nil

        
        NetworkUtility.downloadImage(url: cell.imageURL) { (image) in
            if cell.imageURL == imageUrl, let image = image  {
                DispatchQueue.main.async {
                    cell.photoImage.image = image
                }
            }
        }
        
        return cell
    }
    
}

