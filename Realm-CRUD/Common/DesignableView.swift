//
//  designableView.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class MyyDesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
