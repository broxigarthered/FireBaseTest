//
//  DataTableViewCell.swift
//  FireBaseTest
//
//  Created by Nikolay N. Dutskinov on 01/11/2018.
//  Copyright © 2018 Nikolay N. Dutskinov. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  
  override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  

}
