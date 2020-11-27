//
//  PhotoViewController.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation
import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    var spinner = UIActivityIndicatorView()
    var photos = [Photo]()
    
    @IBOutlet var myCollectionView : UICollectionView!
  
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("collectionview 讀取成功")
        
        spinner.style = .medium
        spinner.color = .systemBlue
        spinner.hidesWhenStopped = true
        print("spinner.hidesWhenStopped = true")

        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300.300), spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
       
        spinner.startAnimating()
        print("spinner.startAnimating()")
        

        
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
               layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/4)
               layout.minimumInteritemSpacing = 0
               layout.minimumLineSpacing = 0
              myCollectionView!.collectionViewLayout = layout
        
      /*
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        // let width = (view.bounds.width - 100) / 2
        
        layout?.sectionInset = UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1) // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout?.itemSize = CGSize(width: view.bounds.width/4, height: view.bounds.width/4) // cell的寬、高
        layout?.scrollDirection = UICollectionView.ScrollDirection.vertical

        layout?.minimumLineSpacing = 0;
        layout?.minimumInteritemSpacing = 0;
 */
        
        
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
                    print("stopSpinning")
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
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

        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .systemBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PHOTO_CELL", for: indexPath) as! PhotoCollectionViewCell
        

        let photo = photos[indexPath.item]

        
        let imageUrl = URL(string: photo.url!)

        cell.title.text = photo.title
        cell.id.text = String (photo.id!)
        cell.imageURL = imageUrl
        cell.photoImage.image = nil
        
        cell.addSubview(spinner)
        
        NSLayoutConstraint.activate([ spinner.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 50.50), spinner.centerXAnchor.constraint(equalTo: cell.centerXAnchor)])

 
            NetworkController.fetchImage(url: cell.imageURL ) { (image) in
                   if cell.imageURL == imageUrl, let image = image  {
                       DispatchQueue.main.async {
                           cell.photoImage.image = image
                           spinner.stopAnimating()
                       }
                   }
            }

        return cell
    }

   
    
}

