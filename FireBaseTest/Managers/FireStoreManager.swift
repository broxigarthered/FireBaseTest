//
//  FireStoreManager.swift
//  FireBaseTest
//
//  Created by Nikolay N. Dutskinov on 31/10/2018.
//  Copyright © 2018 Nikolay N. Dutskinov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore


enum PropertiesType : String {
  case firstName = "firstName"
  case middleName = "middleName"
  case lastName = "lastName"
  case age = "age"
}

enum CollectionsTypes: String {
  case users = "users"
}

protocol FireStoreManagerDelegate: class  {
  func passSingleUserData(user: User)
  func passAllUsers(data: [User])
}

class FireStoreManager  {
  
  weak var delegate: FireStoreManagerDelegate?
  
  static let sharedInstance = FireStoreManager()
  
  private let db = Firestore.firestore()
  private var ref: DocumentReference? = nil
  
  private init (){
    
  }
  
  // ADD SINGLE USER TO FIREBASE
  func addUserToCollection(collection: String, userProperties: [String : Any]) {
  
    let usersRef = db.collection(collection)
    
    // gets the first with that name and updates it if it exists or creates new if it doesn't
    usersRef.document(userProperties[PropertiesType.firstName.rawValue] as! String).setData(userProperties) {
      error in
      if let err = error {
        print("Error adding document \(err)")
        
      } else {
        self.loadDataForUser(collection: collection, user: userProperties[PropertiesType.firstName.rawValue] as! String)
        print ("Document added with id: \(String(describing: self.ref?.documentID))")
      }
    }
  }
  
  // LOADING All AND SINGLE USERS
  func loadAllDataForCollection(collection: String) {
    
    db.collection(collection).getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        if let result = UserFactory.createUsersFromQuerySnapshot(querySnapshot: querySnapshot!){
            self.delegate?.passAllUsers(data: result)
        } else {
          print("Error loading data in loadAllDataForCollection")
        }
      }
    }
  }
  
  func loadDataForUser(collection: String, user: String){
    let userRef = db.collection(collection).document(user)
    
    let secondTestQueryRef = db.collection(collection)
    .whereField(PropertiesType.firstName.rawValue, isEqualTo: user)
    

    
    //// Create a query against the collection.
    //let query = citiesRef.whereField("state", isEqualTo: "CA")
    
    userRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        
        if let user = UserFactory.createUserOfDocumentSnapshot(documentSnapshot: document) {
            self.delegate?.passSingleUserData(user: user)
        }
        
        print(dataDescription)
      } else {
        print("Document doesn't exists")
      }
    }
  }
  
  func updateUser(firstName: String, lastName: String, age: String) {
    
  }
  
  func deleteUser(firstname: String, collectionType: String){
      db.collection(collectionType)
  }
}

