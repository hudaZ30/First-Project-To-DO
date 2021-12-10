//
//  TodoVC.swift
//  First Project To DO
//
//  Created by Tim on 23/04/1443 AH.
//

import UIKit
import CoreData

class TodoVC: UIViewController {

    var todoArr: [Todo] = [
    ]
    
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        self.todoArr = TodoStorage.getTodo()
        
        super.viewDidLoad()
        
    
         // New Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(newTodoAdded), name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil)
       // Edit Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEdited) , name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil)
        // Delete Todo Notification
        NotificationCenter.default.addObserver(self, selector: #selector(todoDeleted) , name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil)

        todoTableView.dataSource = self
        todoTableView.delegate = self

    }
    @objc func newTodoAdded(noti:Notification)
    {
        if let myTodo = noti.userInfo?["addedTodo"] as? Todo {
            todoArr.append(myTodo)
            todoTableView.reloadData()
            TodoStorage.storeTodo(todo: myTodo)
        }
    }
    @objc func currentTodoEdited(notif: Notification){
        if let todo = notif.userInfo?["editedTodo"] as? Todo {
            if let index = notif.userInfo?["editedTodoIndex"] as? Int {
            todoArr[index] = todo
            todoTableView.reloadData()
                TodoStorage.updateTodo(todo: todo, index: index)
            
        }
    }
    }
    
    @objc func todoDeleted(notifi: Notification)
{
    if let index = notifi.userInfo?["deletedTodoIndex"] as? Int {
        todoArr.remove(at:  index)
        todoTableView.reloadData()
        TodoStorage.deleteTodo(index: index)
    }

}
    
}
extension TodoVC: UITableViewDataSource, UITableViewDelegate
    {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! TodoCell
       
        cell.todoTitleLabel.text = todoArr[indexPath.row].title
//        cell.todoImagView.image = todoArr[indexPath.row].image

        // ال اف في حاله ماعندي صوره
            if todoArr[indexPath.row].image != nil {
            cell.todoImagView.image = todoArr[indexPath.row].image

        }else {
            cell.todoImagView.image = UIImage(named: "كتب")
            
        }
        // هذا الكود عشان الصوره تكون بشكل دائري
        cell.todoImagView.layer.cornerRadius = cell.todoImagView.frame.width/2
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // هذا الكود عشان يوخر التضليل الي يكون على الخيارات
        tableView.deselectRow(at: indexPath, animated: true)
        
        let todo = todoArr[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as? TodoDetailsVC
        
        if let viewCont = vc {
            viewCont.todo = todo
            
            viewCont.index = indexPath.row
            
            // ال اف في حاله ابغى اتاكد من وجوده النفيقيشن
//            if let nc = navigationController {
//                nc.pushViewController(viewCont, animated: true)
//            }
            navigationController?.pushViewController(viewCont, animated: true)
    }
    }

}

