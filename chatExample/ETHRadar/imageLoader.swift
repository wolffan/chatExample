//
//  imageLoader.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 27/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView
{
    func downloadFrom(link:URL)
    {
        URLSession.shared.dataTask(with: link as URL, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil else {
                DispatchQueue.main.async {
                    self.isHidden = true
                    self.layoutSubviews()
                }
                return
            }
            DispatchQueue.main.async() { () -> Void in
                if let image = UIImage(data: data) {
                    self.isHidden = false
                    self.configureImageView()
                    self.image = image
                } else {
                    self.isHidden = true
                }
                self.layoutSubviews()
            }
        }).resume()
    }
    
    func configureImageView() {
        layer.cornerRadius = 20.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }
}
