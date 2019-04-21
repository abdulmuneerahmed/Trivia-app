//
//  Alert.swift
//  Trivia
//
//  Created by admin on 19/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

// MARK: - Refactoring Alert -
struct Alert {
    static func showAlert(on vc:UIViewController, with title:String = "", message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert,animated: true)
        }
        
    }
}
