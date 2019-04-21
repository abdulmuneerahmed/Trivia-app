//
//  Extensions.swift
//  Trivia
//
//  Created by admin on 18/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit


// MARK: - Extension For AutoLayout Constraints -
extension UIView {
    
    func setAnchor(width: CGFloat, height: CGFloat) {
        self.setAnchor(top: nil,
                       left: nil,
                       bottom: nil,
                       right: nil,
                       paddingTop: 0,
                       paddingLeft: 0,
                       paddingBottom: 0,
                       paddingRight: 0,
                       width: width,
                       height: height)
    }
    
    func setAnchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                   bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                   paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                   paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
}

// MARK: - Extension For TextField -
extension UITextField{
    func setPadding(_ spacing:CGFloat,_ image:String = ""){
        if image != ""{
            self.leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: spacing, y: 0, width: 20, height: 20))
            imageView.image = UIImage(named: image)
            let space = spacing + 30
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height: 20))
            paddingView.addSubview(imageView)
            self.leftView = paddingView
            
        }
        else{
            self.leftViewMode = .always
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.size.height))
            self.leftView = paddingView
            
        }
        
    }
}

// MARK: - Function For StackViews -
func stackViews(stackViews views:[UIView]) -> UIStackView{
    let stackView = UIStackView(arrangedSubviews: views)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
}



