//
//  PhotoCollectionViewCell.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import Foundation
import UIKit

class PhotoCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var thu: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    var imageURL : URL!
    
    var photoCollectionViewCellViewModel : PhotoCollectionViewCellViewModel?{
        didSet{
            title.text = photoCollectionViewCellViewModel?.titleText
            id.text = photoCollectionViewCellViewModel?.idText
            imageURL = URL(string: photoCollectionViewCellViewModel!.imageURL)
            
            photoImage.image = photoCollectionViewCellViewModel?.photoImage.image
            
            // photoImage.image = photoCollectionViewCellViewModel?.image
            
            
            /*
            NetworkController.fetchImage(url: self.imageURL ) { (image) in
                if self.imageURL == self.imageURL, let image = image  {
                       DispatchQueue.main.async {
                           self.photoImage.image = image
                       }
                   }
            }
            */
        }
    }
  
}
