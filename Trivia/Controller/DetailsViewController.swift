//
//  DetailsViewController.swift
//  Trivia
//
//  Created by admin on 20/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Constants -
    private let service = QuizService.service
    
    // MARK: - Variables -
    var history:History?{
        didSet{
            answer1.text = history?.answer1
            answer2.text = history?.answer2
        }
    }
    
    // MARK: - View Methods -
    override func loadView() {
        super.loadView()
        addViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 36/255, green: 42/255, blue: 64/255, alpha: 1)
        updateQuestionAndAnswer()
    }
    
    // MARK: - Defined Views -
    fileprivate lazy var question1:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Bold", size: 20)
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var answer1:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Medium", size: 20)
        label.textColor = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    fileprivate lazy var question2:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Bold", size: 20)
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var labe1:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Medium", size: 20)
        label.text = "Answered : "
        label.textColor = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var labe2:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Medium", size: 20)
        label.text = "Answered : "
        label.textColor = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var answer2:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Medium", size: 20)
        label.textColor = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    // MARK: - Adding SubViews -
    private func addViews(){
        
        let answeredStack1 = stackViews(stackViews: [labe1,answer1])
        answeredStack1.axis = .vertical
        answeredStack1.spacing = 0
        
        let qunOneStackView = UIStackView(arrangedSubviews: [question1,answeredStack1])
        qunOneStackView.axis = .vertical
        
        let answeredStack2 = stackViews(stackViews: [labe2,answer2])
        answeredStack2.axis = .vertical
        answeredStack2.spacing = 0
        let qunTwoStackView = UIStackView(arrangedSubviews: [question2,answeredStack2])
        qunTwoStackView.axis = .vertical
        
        let questionView = UIStackView(arrangedSubviews: [qunOneStackView,qunTwoStackView])
        questionView.axis = .vertical
        questionView.spacing = 20
        
        view.addSubview(questionView)
        questionView.setAnchor(width: view.frame.width - 100, height: 300)
        NSLayoutConstraint.activate([
            questionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    // MARK: - Updating Questions -
    private func updateQuestionAndAnswer(){
        question1.text = "1. \(service.getQuestions()[0].question)"
        question2.text = "2. \(service.getQuestions()[1].question)"
    }

}
