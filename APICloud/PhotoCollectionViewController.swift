//
//  PhotoViewController.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation
import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    var viewModel: PhotoCollectionViewModel = {
        return PhotoCollectionViewModel()
    }()
    
    var spinner = UIActivityIndicatorView()
    // var photos = [Photo]()
    
    @IBOutlet var myCollectionView : UICollectionView!
  
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        
        viewModel.updateLoadingStauts = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.spinner.startAnimating()
                }
                else {
                    self?.spinner.stopAnimating()
                }
            }
        }
        
        
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.myCollectionView.reloadData()
            }
        }
        
        // -------------------------------------
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
        

        viewModel.initFetch()
        
    }
        
 

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("collectionview_return_count:: ")
        print(viewModel.numberOfCells)
        return viewModel.numberOfCells
        
    }
  
    /*
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       print(" override func collectionViewvggg")
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
    */
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PHOTO_CELL", for: indexPath) as! PhotoCollectionViewCell
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        
        cell.photoCollectionViewCellViewModel = cellVM
        return cell
    }

   
    
}

