//
//  Person.swift
//  Trivia
//
//  Created by admin on 19/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import Foundation

struct Name {
    let personName:String
    init(personName:String) {
        self.personName = personName
    }
}

class Service{
    var personName:Name!
    static let service = Service()
    private init() {}
    func name()->Name{
        return personName
    }
}








