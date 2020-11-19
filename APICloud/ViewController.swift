//
//  ViewController.swift
//  APICloud
//
//  Created by 江柏毅 on 2020/11/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var ApiButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiButton.addTarget(self, action: #selector(self.clickButton(_:)), for: .touchDown)
    }

    @objc func clickButton(_ button: UIButton) {
        
        guard let nav = navigationController else {
            return
        }
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "PHOTO") as? PhotoCollectionViewController {
            
            nav.pushViewController(controller, animated: true)
            
        }
        
        
    }
    

}

