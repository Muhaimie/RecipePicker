//
//  CookingStepTableViewCell.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class CookingStepTableViewCell: UITableViewCell{
    
    @IBOutlet weak var stepCountLabel: UILabel!
    
    @IBOutlet weak var stepTextField: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDelegate(dataSourceDelegate : UITextFieldDelegate, forRow row: Int){
        stepTextField.delegate = dataSourceDelegate
        stepTextField.tag = row
    }

}
