//
//  Utils.swift
//  Realm-CRUD
//
//  Created by Vavdiya Haresh on 29/12/20.
//  Copyright © 2020 Vavdiya Haresh. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    //@return true if trimmed equals an empty string
    public var isTrimmedEmpty: Bool {
        get {
            return self.trimmingCharacters(in: CharacterSet(charactersIn: " \t\n\r")).count == 0
        }
    }
}
//MARK - view controller util
extension UIViewController {
    func alert(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(title:String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
