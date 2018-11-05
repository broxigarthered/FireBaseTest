//
//  Extensions.swift
//  FireBaseTest
//
//  Created by Nikolay N. Dutskinov on 05/11/2018.
//  Copyright © 2018 Nikolay N. Dutskinov. All rights reserved.
//

import Foundation
import UIKit


extension ViewController {
  // Function for hiding keyboard upon tap
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
