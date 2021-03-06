//
//  NewTodoVC.swift
//  First Project To DO
//
//  Created by Tim on 24/04/1443 AH.
//

import UIKit

class NewTodoVC: UIViewController{

    var isCreation = true
    var editedTodo: Todo?
    var editedTodoIndex: Int?
    
    
    @IBOutlet weak var todoImagView: UIImageView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        if !isCreation {
            mainButton.setTitle("تعديل", for: .normal)
            navigationItem.title = "تعديل مهمة"
            
            if let todo = editedTodo {
                titleTextField.text = todo.title
                detailsTextView.text = todo.details
                todoImagView.image = todo.image
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func changeButtonClicked(_ sender: Any) {
        let imagPicker = UIImagePickerController()
        imagPicker.delegate = self
        imagPicker.allowsEditing = true
        present(imagPicker, animated: true, completion: nil)
       
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if isCreation {
            let todo = Todo(title: titleTextField.text!, image: todoImagView.image, details: detailsTextView.text)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NewTodoAdded"), object: nil, userInfo: ["addedTodo": todo])
            
            
            let alert = UIAlertController(title: "تمت الإضافة", message: "تم إضافة المهمة بنجاح", preferredStyle: UIAlertController.Style.alert)
            
            let closeAction = UIAlertAction(title: "تم", style: UIAlertAction.Style.default) {
                _ in self.tabBarController?.selectedIndex = 0
             
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                
        }
            alert.addAction(closeAction)
            present(alert, animated: true, completion: {
              
            })

        }else { //else if the ViewControllar is opened for edit (not for creat)
            let todo = Todo(title: titleTextField.text!, image: todoImagView.image, details: detailsTextView.text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentTodoEdited"), object: nil, userInfo: ["editedTodo": todo, "editedTodoIndex": editedTodoIndex])
            
            let alert = UIAlertController(title: "تم التعديل", message: "تم تعديل المهمة", preferredStyle: UIAlertController.Style.alert)
            
            let closeAction = UIAlertAction(title: "تم", style: UIAlertAction.Style.default) {
                _ in self.navigationController?.popViewController(animated: true)
             
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                
        }
            alert.addAction(closeAction)
            present(alert, animated: true, completion: {
              
            })
    }
  }
}

extension NewTodoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imag = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        dismiss(animated: true, completion: nil)
        todoImagView.image = imag
    }
}
