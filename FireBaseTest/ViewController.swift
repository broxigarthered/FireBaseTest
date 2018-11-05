//
//  ViewController.swift
//  FireBaseTest
//
//  Created by Nikolay N. Dutskinov on 24/10/2018.
//  Copyright © 2018 Nikolay N. Dutskinov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, FireStoreManagerDelegate {
  
  var singleUser: [String : Any]? = nil
  var allUsers: [User] = []
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    FireStoreManager.sharedInstance.loadAllDataForCollection(collection: "users")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    // remove the observer of ref
    //FireStoreManager.sharedInstance.removeListener()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    FireStoreManager.sharedInstance.delegate = self
    //FireStoreManager.sharedInstance.loadAllDataForCollection(collection: "users")
    
    //FireStoreManager.sharedInstance.loadDataForUser(collection: "users", user: "Niki")
  }
  
  // MARK: Button methods
  
  @IBAction func didClickDelete(_ sender: Any) {
  }
  
  @IBAction func didClickUpdate(_ sender: Any) {
    guard let name = self.firstNameTextField.text,
    let lastName = self.lastNameTextField.text,
    let age = self.ageTextField.text
      else { return }
    
    FireStoreManager.sharedInstance.updateUser(firstName: name, lastName: lastName, age: age)
  }
  
  @IBAction func didClickLoad(_ sender: Any) {
    Analytics.logEvent("Saving new person in db", parameters: nil)
    
    let newUser = UserFactory.createUser(firstName: firstNameTextField.text, lastName: lastNameTextField.text, age: ageTextField.text)
    FireStoreManager.sharedInstance.addUserToCollection(collection: "users", userProperties: newUser)
  }
  
  
  // FireStoreManagerDelegate
  
  func passAllUsers(data: [User]) {
    self.allUsers = data
    tableView.reloadData()
  }
  
  func passSingleUserData(user: User) {
    self.allUsers.append(user)
    self.tableView.reloadData()
  }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allUsers.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! DataTableViewCell
    
    // set the properties of the cell
    let currentUserInformation = self.allUsers[indexPath.row]
    
    
    cell.firstNameLabel.text = currentUserInformation.name
    cell.lastNameLabel.text = currentUserInformation.lastName
    cell.ageLabel.text = currentUserInformation.age
    
    
    return cell
  }
}

