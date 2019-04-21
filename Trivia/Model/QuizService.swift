//
//  QuizService.swift
//  Trivia
//
//  Created by admin on 21/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

class QuizService{
    
    static let service = QuizService()
    
    var answer1:String?
    var answer2:[String] = []
    
    private init(){}
    
    private let questions = [
        QuizQuestions(question: "Who is the best cricketer in the World?", options: ["Sachin Tendulkar","Virat Kohli","Adam Gilchirst","Jacques Kallis"],questionType:.anyone),
        QuizQuestions(question: "What are the colors in the Indian national flag?", options: ["White","Yellow","Orange","Green"],questionType:.multiple)
    ]
    
    func getQuestions()->[QuizQuestions]{
        return questions
    }
    
    func getanswer1()->String?{
        return answer1
    }
    
    func getanswer2()->[String]{
        return answer2
    }
}
