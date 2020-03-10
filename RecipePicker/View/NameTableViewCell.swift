//
//  NameTableViewCell.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 10/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func textFieldDelegate(dataSourceDelegate : UITextFieldDelegate, forRow row: Int){
        nameTextField.delegate = dataSourceDelegate
        nameTextField.tag = row
    }
    
    
    
    
    
}
