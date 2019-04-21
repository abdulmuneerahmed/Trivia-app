//
//  CoreData.swift
//  Trivia
//
//  Created by admin on 20/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit
import CoreData

func save(name:String,answer1:String,answer2:String){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "History", in: managedContext)!
    
    let person = NSManagedObject(entity: entity, insertInto: managedContext)
    
    person.setValue(name, forKey: "name")
    person.setValue(NSDate(), forKey: "date")
    person.setValue(answer2, forKey: "answer2")
    person.setValue(answer1, forKey: "answer1")
    
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Could Not Save. \(error), \(error.userInfo)")
    }
}
