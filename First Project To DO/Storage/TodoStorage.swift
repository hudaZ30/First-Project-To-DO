//
//  TodoStorage.swift
//  First Project To DO
//
//  Created by Tim on 01/05/1443 AH.
//

import UIKit
import CoreData

class TodoStorage {
    
    static func storeTodo(todo: Todo){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let mangeContext = appdelegate.persistentContainer.viewContext
        
        guard let todoEntity = NSEntityDescription.entity(forEntityName: "Todos", in: mangeContext) else { return }
        let todoObj = NSManagedObject.init(entity: todoEntity, insertInto: mangeContext)
        todoObj.setValue(todo.title, forKey: "title")
        todoObj.setValue(todo.details, forKey: "details")
       
        if let image = todo.image {
            let imageData = image.jpegData(compressionQuality: 1)
            todoObj.setValue(imageData, forKey: "image")
        }
        do {
          try  mangeContext.save()
            print("=========success=========")
        }catch {
            print("=========error==========")
        }
       
    }
    
    static func updateTodo(todo: Todo, index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        do {
           let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            result[index].setValue(todo.title, forKey: "title")
            result[index].setValue(todo.details, forKey: "details")
            if let image = todo.image {
                let imageData = image.jpegData(compressionQuality: 1)
                result[index].setValue(imageData, forKey: "image")
                
            }
            try context.save()
            
        }catch {
            print("=======error========")
        }
    }
    
    static func deleteTodo(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        do {
           let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
          let todoDelet = result[index]
            context.delete(todoDelet)
            
            try context.save()
            
        }catch {
            print("=======error========")
        }
    }
    
    static func getTodo() -> [Todo] {
        var todos: [Todo] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return []}
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        do {
           let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for manageTodo in result {
                print(manageTodo)
                let title = manageTodo.value(forKey: "title") as? String
                let details = manageTodo.value(forKey: "details") as? String
                
                var todoImage: UIImage? = nil
                if let imageFromContext = manageTodo.value(forKey: "image") as? Data {
                     todoImage = UIImage(data: imageFromContext)
                }
                let todo = Todo(title: title ?? "", image: todoImage, details: details ?? "")
             todos.append(todo)
            }
        }catch {
            print("=======error========")
        }
        return todos
    }
}

