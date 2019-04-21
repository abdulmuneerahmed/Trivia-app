//
//  QuizQuestions.swift
//  Trivia
//
//  Created by admin on 21/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

struct QuizQuestions{
    let question:String
    let options:[String]
    let questionType:QuestionType
    init(question:String,options:[String],questionType:QuestionType) {
        self.question = question
        self.options = options
        self.questionType = questionType
    }
}
