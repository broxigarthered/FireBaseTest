//
//  UserFactory.swift
//  FireBaseTest
//
//  Created by Nikolay N. Dutskinov on 31/10/2018.
//  Copyright © 2018 Nikolay N. Dutskinov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

struct UserFactory {
  static func createUser(firstName: String?, lastName: String?, age: String?) -> [String : Any]{
    
    guard let firstName = firstName, let lastName = lastName, let age = age else { return [String : Any]() }
    
    return [PropertiesType.firstName.rawValue : firstName,
            PropertiesType.lastName.rawValue : lastName,
            PropertiesType.age.rawValue : age]
  }
  
  static func createUserOfDocumentSnapshot(documentSnapshot: DocumentSnapshot) -> User? {
    if let data = documentSnapshot.data(){
      let newUser = User(name: data[PropertiesType.firstName.rawValue] as! String,
                         lastName: data[PropertiesType.lastName.rawValue] as! String,
                         age: data[PropertiesType.age.rawValue] as! String)
      return newUser
    }
    
    return nil
   
  }
  
  static func createUsersFromQuerySnapshot(querySnapshot: QuerySnapshot) -> [User]? {
    
    var users: [User] = [User]()
    
    for document in querySnapshot.documents {
      
      if let newUser = UserFactory.createUserOfDocumentSnapshot(documentSnapshot: document) {
          users.append(newUser)
      }
      
      
//      print("\(document.documentID) => \(document.data())")
//      print(document.documentID)
//      print(document.data())
    }
    
    return users
    
  }
  
  
}
