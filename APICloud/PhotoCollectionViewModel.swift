//
//  PhotoCollectionViewModel.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/27.
//

import Foundation
import UIKit

class PhotoCollectionViewModel {
    var isLoading : Bool = false {
        didSet {
            self.updateLoadingStauts?()
        }
    }
    
    private var photos: [Photo] = [Photo]()
    
    var reloadCollectionViewClosure: (()->())?
    var updateLoadingStauts: (()->())?
    

    var numberOfCells : Int {
        return cellViewModels.count
    }
    
    private var cellViewModels: [PhotoCollectionViewCellViewModel] = [PhotoCollectionViewCellViewModel](){
        didSet{
            self.reloadCollectionViewClosure?()
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PhotoCollectionViewCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(photo: Photo) -> PhotoCollectionViewCellViewModel {

        return PhotoCollectionViewCellViewModel(titleText: photo.title!, idText: String(photo.id!), imageURL: photo.url!, photoImage: UIImageView())
    }
    
    
    func initFetch() {
        
        self.isLoading = true;
        
        let apiUrl = "https://jsonplaceholder.typicode.com/photos"
        
  

        if let url = URL (string: apiUrl ) {
           print("url")
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let jsonData = try? JSONDecoder().decode([Photo].self, from: data) {

                    print("url:: " + apiUrl)
                    print("data:: ", jsonData.count)
                    
                    self.photos = jsonData

                    var vms = [PhotoCollectionViewCellViewModel]()
                    for photo in self.photos {
                        vms.append(self.createCellViewModel(photo: photo))
                    }
                    
                    self.cellViewModels = vms
                    
                    print("stopSpinning")
                    
                    DispatchQueue.main.async {
                        self.isLoading = false
                        print("isLoading = false")
                    }
                }
            }
            task.resume()
        }
    }
    
}
