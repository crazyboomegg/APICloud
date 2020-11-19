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
}
