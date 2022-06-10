//
//  ChatVC.swift
//  Chat App
//
//  Created by HAMZA on 30/5/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Identifiers.cellNibName, bundle: nil), forCellReuseIdentifier: Identifiers.cellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        
        db.collection(CloudStore.collectionName)
            .order(by: CloudStore.dateField)
            .addSnapshotListener { querySnapShot, error in
            
            self.messages = []
            if let e = error {
                print("There was an issue to retreive data,\(e)")
            } else {
                if let snapDocument = querySnapShot?.documents {
                    for document in snapDocument {
                        if let messageSender = document.data()[CloudStore.senderField] as? String,
                           let messageBody = document.data()[CloudStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, bodyMsg: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let index = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: index, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
        
        
    }
    
    
    @IBAction func sendClicked(_ sender: UIButton) {
        
        if let messageBody = msgTextField.text, let messageSender = Auth.auth().currentUser?.email {
                
            db.collection(CloudStore.collectionName).addDocument(data: [
                CloudStore.senderField: messageSender,
                CloudStore.bodyField: messageBody,
                CloudStore.dateField: Date().timeIntervalSince1970]) { error in
                if let e = error {
                    print("there was a problem to saving data , \(e)")
                } else {
                    print("Succes")
                    
                    DispatchQueue.main.async {
                        self.msgTextField.text = ""
                    }
                    
                }
            }
        }
        
        
        
    }
    
    @IBAction func logOutClicked(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}


extension ChatVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].bodyMsg
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImgView.isHidden = true
            cell.rightImgView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: BrandColors.purple)
        } else {
            cell.leftImgView.isHidden = false
            cell.rightImgView.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: BrandColors.purple)
            cell.label.textColor = UIColor(named: BrandColors.lightPurple)
        }
        
        
        
        
        return cell
    }
}
