//
//  PhotoCollectionViewCellViewModel.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/27.
//

import Foundation
import UIKit

struct PhotoCollectionViewCellViewModel {
    let titleText : String
    let idText : String
    let imageURL : String
    let photoImage : UIImageView

    func getImage () {
        let imageURL = URL(string:self.imageURL)!
        NetworkController.fetchImage(url: imageURL ) { (image) in
               if imageURL == imageURL, let image = image  {
                   DispatchQueue.main.async {
                    photoImage.image = image
                   }
               }
        }
    }
}

