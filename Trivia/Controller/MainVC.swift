//
//  ViewController.swift
//  Trivia
//
//  Created by admin on 18/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Constants -
    let personNameService = Service.service
    
    // MARK: - View Methods -
    override func loadView() {
        super.loadView()
        addSubViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 36/255, green: 42/255, blue: 64/255, alpha: 1)
        
        addGesture()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    // MARK: - Adding Subviews Function -
    fileprivate func addSubViews(){
        
        let stackView = stackViews(stackViews: [userName,nextButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.setAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        stackView.setAnchor(width: 0, height: 110)
        
    }

    // MARK: - GestureFunction -
    fileprivate func addGesture(){
        userName.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Defined Views -
    fileprivate lazy var userName:UITextField = {
        let username = UITextField()
        username.backgroundColor = .clear
        username.layer.cornerRadius = 5
        username.placeholder = "UserName"
        username.borderStyle = .none
        username.layer.borderColor = UIColor.white.cgColor
        username.layer.borderWidth = 2
        username.textColor = .white
        username.font = UIFont(name: "Avenirnext-Heavy", size: 18)
        username.allowsEditingTextAttributes = true

        username.setPadding(20)
        //Placeholder
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "UserName", attributes: [NSMutableAttributedString.Key.font:UIFont(name: "Avenirnext-Heavy", size: 18)!,.foregroundColor:UIColor(white: 1, alpha: 0.7)]))
        username.attributedPlaceholder = placeholder
        
        return username
    }()
    
    
    fileprivate lazy var nextButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 5
        btn.layer.borderColor = UIColor.orange.cgColor
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 20)
        btn.backgroundColor = .orange
        btn.setAnchor(width: 0, height: 45)
        btn.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Selectors -
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func handleNextButton(){
       
        let characters = userName.text?.trimmingCharacters(in: .whitespaces)
        
        if let userName = userName.text, characters!.count != 0{
            personNameService.personName = Name(personName: userName)
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: QuizVC())
        }else{
            Alert.showAlert(on: self, with: "UserName", message: "Please enter Valid UserName")
        }
        
    }
   
}


// MARK: - Extensions -
extension MainVC:UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userName.resignFirstResponder()
        return true
    }
    
    
}
