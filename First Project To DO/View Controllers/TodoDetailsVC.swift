//
//  TodoDetailsVC.swift
//  First Project To DO
//
//  Created by Tim on 24/04/1443 AH.
//

import UIKit

class TodoDetailsVC: UIViewController {

    var todo: Todo!
    var index: Int!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var todoTitleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // حطينا اف في حاله اذا فيه وحده من المهام ماعنده صوره
        if todo.image != nil {
            todoImageView.image = todo.image
            
        }else {
            todoImageView.image = UIImage(named: "كتب")
        }
//        todoImageView.image = todo.image //اذا ماحطيت اف اشغل ذي
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(currentTodoEdited) , name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil)
    }
    
    @objc func currentTodoEdited(notif: Notification)
    {
        if let todo = notif.userInfo?["editedTodo"] as? Todo
        {
            self.todo = todo
            setupUI()
        }
    }
    func setupUI(){
        todoTitleLabel.text = todo.title
        detailsLabel.text = todo.details
        todoImageView.image = todo.image
        
    }

    @IBAction func addedTodoButtonClicked(_ sender: Any)
    {
        if let viewCount = storyboard?.instantiateViewController(withIdentifier: "NewTodoVC") as? NewTodoVC {
            viewCount.isCreation = false
            viewCount.editedTodo = todo
            viewCount.editedTodoIndex = index
            navigationController?.pushViewController(viewCount, animated: true)
           
        }
        
    }
    @IBAction func deleteButtonClicked(_ sender: Any) {
        let alert = MyAlertViewController(
            title: "تنبيه",
            message: "هل أنت متاكد من الحذف؟",
            imageName: "warning_icon")

       
        alert.addAction(title: "نعم", style: .default) { alert in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil, userInfo: ["deletedTodoIndex": self.index])
            
            let alert = MyAlertViewController(
                title: "تم",
                message: "تم الحذف بنجاح",
                imageName: "warning_icon")

            alert.addAction(title: "تم", style: .default) { alert in
                self.navigationController?.popViewController(animated: true)
            }
            self.present(alert, animated: true, completion: nil)
        }
        alert.addAction(title: "إلغاء", style: .cancel)

        present(alert, animated: true, completion: nil)
        
        
//        let confirmAlert = UIAlertController(title: "تنبيه", message: "هل أنت متأكد من إتمام عملية الحذف؟", preferredStyle: .alert)
//
//        let confirmAction = UIAlertAction(title: "تأكيد الحذف", style: .destructive) { alert in
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TodoDeleted"), object: nil, userInfo: ["deletedTodoIndex": self.index])
//
//        let alert = UIAlertController(title: "تم", message: "تم حذف المهمة بنجاح", preferredStyle: .alert)
//        let closeAction = UIAlertAction(title: "تم", style: .default) { alert in
//            self.navigationController?.popViewController(animated: true)
//        }
//        alert.addAction(closeAction)
//            self.present(alert, animated: true, completion: nil)
//    }
//        confirmAlert.addAction(confirmAction)
//
//        let cancelAction = UIAlertAction(title: "إغلاق", style: .default, handler: nil)
//        confirmAlert.addAction(cancelAction)
//
//        present(confirmAlert, animated: true, completion: nil)
//}
}
}
