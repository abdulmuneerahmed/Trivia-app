//
//  QuestionCollectionViewCell.swift
//  Trivia
//
//  Created by admin on 19/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables&Constants -
    var quizOptionType:QuestionType!
    
    let qunService = QuizService.service
    
    // MARK: - Cell Methods -
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewsToCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Defined Views -
    fileprivate lazy var questionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenirnext-Bold", size: 20)
        label.textColor = .white
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var firstOption:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.tag = 0
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont(name: "Avenirnext-Bold", size: 18)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(choosingAnswer(option:)), for: .touchUpInside)
        btn.setAnchor(width: 0, height: 47)
        return btn
    }()
    fileprivate lazy var secondOption:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.tag = 1
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont(name: "Avenirnext-Bold", size: 18)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(choosingAnswer(option:)), for: .touchUpInside)
        btn.setAnchor(width: 0, height: 47)
        return btn
    }()
    fileprivate lazy var thirdOption:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.tag = 2
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont(name: "Avenirnext-Bold", size: 18)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(choosingAnswer(option:)), for: .touchUpInside)
        btn.setAnchor(width: 0, height: 47)
        return btn
    }()
    fileprivate lazy var fourOption:UIButton = {
        let btn = UIButton()
        btn.tag = 3
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont(name: "Avenirnext-Bold", size: 18)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(choosingAnswer(option:)), for: .touchUpInside)
        btn.setAnchor(width: 0, height: 47)
        return btn
    }()
    
    
    // MARK: - Adding Views -
    fileprivate func addSubviewsToCell(){
        self.addSubview(questionLabel)
        questionLabel.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        questionLabel.heightAnchor.constraint(equalToConstant:100)
        let stackView = stackViews(stackViews: [firstOption,secondOption,thirdOption,fourOption])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        stackView.setAnchor(top: questionLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom:0, paddingRight: 0)
        
        
    }
    
    func updateCell(questionsData:QuizQuestions){
        questionLabel.text = questionsData.question
        firstOption.setTitle("\(questionsData.options[0])", for: .normal)
        secondOption.setTitle("\(questionsData.options[1])", for: .normal)
        thirdOption.setTitle("\(questionsData.options[2])", for: .normal)
        fourOption.setTitle("\(questionsData.options[3])", for: .normal)
        quizOptionType = questionsData.questionType
    }
    
    // MARK:- Selectors -
    @objc func choosingAnswer(option sender:UIButton){
        let questionType:QuestionType = quizOptionType
        switch questionType {
        case .anyone:
            chooseSingleAnswer(tag: sender.tag)
        case .multiple:
            chooseMultipleAnswer(tag: sender.tag)
        }
    }
    
    
    // MARK: - Multiple Choice implementation function -
    private func chooseMultipleAnswer(tag:Int){
        switch tag {
        case 0:
            guard let labelText = firstOption.titleLabel?.text else{return}
            if firstOption.backgroundColor == .green{
                firstOption.backgroundColor = .white
                firstOption.setTitleColor(.black, for: .normal)
                if let index = qunService.answer2.index(of:labelText){
                    
                    qunService.answer2.remove(at: index)
                }
            }else{
                firstOption.backgroundColor = .green
                firstOption.setTitleColor(.white, for: .normal)
                qunService.answer2.append(labelText)
            }
            
        case 1:
            guard let labelText = secondOption.titleLabel?.text else{return}
            if secondOption.backgroundColor == .green{
                secondOption.backgroundColor = .white
                secondOption.setTitleColor(.black, for: .normal)
                if let index = qunService.answer2.index(of:labelText){
                    
                    qunService.answer2.remove(at: index)
                }
            }else{
                secondOption.backgroundColor = .green
                secondOption.setTitleColor(.white, for: .normal)
                qunService.answer2.append(labelText)
            }
            
        case 2:
            guard let labelText = thirdOption.titleLabel?.text else{return}
            if thirdOption.backgroundColor == .green{
                thirdOption.backgroundColor = .white
                thirdOption.setTitleColor(.black, for: .normal)
                if let index = qunService.answer2.index(of:labelText){
                    
                    qunService.answer2.remove(at: index)
                }
            }else{
                thirdOption.backgroundColor = .green
                thirdOption.setTitleColor(.white, for: .normal)
                qunService.answer2.append(labelText)
            }
            
        case 3:
            guard let labelText = fourOption.titleLabel?.text else{return}
            if fourOption.backgroundColor == .green{
                fourOption.backgroundColor = .white
                fourOption.setTitleColor(.black, for: .normal)
                
                if let index = qunService.answer2.index(of:labelText){
                    
                    qunService.answer2.remove(at: index)
                }
            }else{
                fourOption.backgroundColor = .green
                fourOption.setTitleColor(.white, for: .normal)
                
                qunService.answer2.append(labelText)
                
            }
            
        default:
            break
        }
    }
    
    // MARK: - Single Choice implementation Function -
    private func chooseSingleAnswer(tag:Int){
        switch tag {
        case 0:
            firstOption.backgroundColor = .green
            firstOption.setTitleColor(.white, for: .normal)
            qunService.answer1 = firstOption.titleLabel?.text
            
            secondOption.backgroundColor = .white
            secondOption.setTitleColor(.black, for: .normal)
            thirdOption.backgroundColor = .white
            thirdOption.setTitleColor(.black, for: .normal)
            fourOption.backgroundColor = .white
            fourOption.setTitleColor(.black, for: .normal)
        case 1:
            secondOption.backgroundColor = .green
            secondOption.setTitleColor(.white, for: .normal)
            qunService.answer1 = secondOption.titleLabel?.text
            
            firstOption.backgroundColor = .white
            firstOption.setTitleColor(.black, for: .normal)
            thirdOption.backgroundColor = .white
            thirdOption.setTitleColor(.black, for: .normal)
            fourOption.backgroundColor = .white
            fourOption.setTitleColor(.black, for: .normal)
        case 2:
            thirdOption.backgroundColor = .green
            thirdOption.setTitleColor(.white, for: .normal)
            qunService.answer1 = thirdOption.titleLabel?.text
            
            firstOption.backgroundColor = .white
            firstOption.setTitleColor(.black, for: .normal)
            secondOption.backgroundColor = .white
            secondOption.setTitleColor(.black, for: .normal)
            fourOption.backgroundColor = .white
            fourOption.setTitleColor(.black, for: .normal)
        case 3:
            fourOption.backgroundColor = .green
            fourOption.setTitleColor(.white, for: .normal)
            qunService.answer1 = fourOption.titleLabel?.text
            
            firstOption.backgroundColor = .white
            firstOption.setTitleColor(.black, for: .normal)
            secondOption.backgroundColor = .white
            secondOption.setTitleColor(.black, for: .normal)
            thirdOption.backgroundColor = .white
            thirdOption.setTitleColor(.black, for: .normal)
        default:
            break
        }
    }
    
}
