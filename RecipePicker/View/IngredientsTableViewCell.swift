//
//  IngredientsTableViewCell.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 10/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit



class IngredientsTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var IngredientTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //IngredientTextField.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: TextField delegate
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        IngredientTextField.resignFirstResponder()
//        return true
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        IngredientTextField.becomeFirstResponder()
//
//    }
    
    //MARK: Set up delegate for the textfield
    func textFieldDelegate(dataSourceDelegate : UITextFieldDelegate, forRow row: Int){
        IngredientTextField.delegate = dataSourceDelegate
        IngredientTextField.tag = row
    }
    
    
    
}
