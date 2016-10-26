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
                return
            }
            DispatchQueue.main.async() { () -> Void in
                self.image = UIImage(data: data)
                self.layoutSubviews()
            }
        }).resume()
    }
}
