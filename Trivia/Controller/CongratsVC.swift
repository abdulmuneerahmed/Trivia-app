//
//  CongratsVC.swift
//  Trivia
//
//  Created by admin on 20/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class CongratsVC: UIViewController {
    
    // MARK: - View Methods -
    override func loadView() {
        super.loadView()
        addSubViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 36/255, green: 42/255, blue: 64/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Defined Views -
    fileprivate lazy var presentesView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate lazy var acheivement:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "winner")
        return imageView
    }()
    
    fileprivate lazy var congrats:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Heavy", size: 25)
        label.text = "Congrats!"
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var replay:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 12)
        label.text = "Replay"
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var history:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 12)
        label.text = "History"
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var home:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 12)
        label.text = "Logout"
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var message:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Bold", size: 18)
        label.text = "Quiz Completed Successfully."
        label.textColor = .black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    fileprivate lazy var replayButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "replay"), for: .normal)
        button.addTarget(self, action: #selector(restart), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var historyButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "history"), for: .normal)
        button.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var homeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Logout"), for: .normal)
        button.addTarget(self, action: #selector(homeAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Adding SubViews -
    private func addSubViews(){
        view.addSubview(presentesView)
        presentesView.setAnchor(width: view.frame.width - 40, height: view.frame.height/2 + (view.frame.height/2)/2)
        NSLayoutConstraint.activate([
            presentesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentesView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        presentesView.layer.cornerRadius = 25
        
        let replayStack = stackViews(stackViews: [replayButton,replay])
        replayStack.axis = .vertical
        replayStack.spacing = 5
        
        let historyStack = stackViews(stackViews: [historyButton,history])
        historyStack.axis = .vertical
        historyStack.spacing = 5
        
        let homeStack = stackViews(stackViews: [homeButton,home])
        homeStack.axis = .vertical
        homeStack.spacing = 5
        
        let bottombar = stackViews(stackViews: [replayStack,historyStack,homeStack])
        bottombar.axis = .horizontal
        bottombar.distribution = .fillEqually
        let stackView = stackViews(stackViews: [acheivement,congrats,message,bottombar])
        stackView.axis = .vertical
        stackView.spacing = 25
        presentesView.addSubview(stackView)
        stackView.setAnchor(width: presentesView.frame.width, height: presentesView.frame.height)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: presentesView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: presentesView.centerYAnchor)
            ])
        replayButton.imageRect(forContentRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        historyButton.imageRect(forContentRect: CGRect(x: 0, y: 0, width: 50, height: 50))
        acheivement.setAnchor(width: presentesView.frame.width/2, height: presentesView.frame.width/2)
    }
    
    // MARK: - Selector -
    @objc func restart(){
        QuizService.service.answer1 = nil
        QuizService.service.answer2.removeAll()
        let quizVC = UINavigationController(rootViewController: QuizVC())
        UIApplication.shared.keyWindow?.rootViewController = quizVC
    }
    
    @objc func historyAction(){
        let historyVC = UINavigationController(rootViewController: HistoryVC())
       present(historyVC,animated: true)
        
    }
    @objc func homeAction(){
        QuizService.service.answer1 = nil
        QuizService.service.answer2.removeAll()
        UIApplication.shared.keyWindow?.rootViewController = MainVC()
    }

}
