//
//  UIView + Extensions.swift
//  Players
//
//  Created by Jameel Shehadeh on 22/07/2023.
//

import UIKit

extension UIView {
    
    func addShadow(
        shadowColor: UIColor = UIColor.gray.withAlphaComponent(0.7),
       shadowOffset: CGSize = CGSize(width: 0.0, height: 3.0),
       shadowOpacity: Float = 0.35,
       shadowRadius: CGFloat = 2) {
      
          layer.shadowColor = shadowColor.cgColor
          layer.shadowOffset = shadowOffset
          layer.shadowOpacity = shadowOpacity
          layer.shadowRadius = shadowRadius
    }
}
