//
//  AddRecipeViewController.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

protocol AddRecipeDelegate {
    
    func addRecipe(newRecipe recipe : Recipe,section : Int? , row : Int?,inEditing editing : Bool)
}


class AddRecipeTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
   //segue parser model from last vc
    var recipeType =  [RecipeType]()
    
    
    var delegate : AddRecipeDelegate?
    
    
    //for editingPage
    var inEditing : Bool?
    var indexInModel: Int?
    var sectionInModel : Int?
    var recipeToEdit : Recipe?
    
    
    //for only showing details (neither edit nor add)
    var inDetailShowing : Bool?
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if inDetailShowing == nil{
            inDetailShowing = false
        }
        
        if inEditing == nil{
            inEditing = false
        }

        // Do any additional setup after loading the view.
        title = "New Recipe"
        self.navigationItem.largeTitleDisplayMode = .never
        
        imagePicker.delegate = self
        
        
        if inEditing == true || inDetailShowing == true{
            
           title = "Edit Recipe"
            
            name = recipeToEdit!.title
            ingredients = recipeToEdit!.ingredients!
            steps = recipeToEdit!.steps!
            
            
            images = (recipeToEdit?.images?.map{UIImage(data: $0)!})!
            
            recipe_Type = recipeToEdit!.recipteType
        
            
        }
        
        

        
        
        
        //make barbutton become edit button in showing detail mode
        
        if inDetailShowing == true{
            self.navigationItem.rightBarButtonItem?.action = nil
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editBarClicked))
        }
        

    }
    
    
   @objc func editBarClicked(){
        inDetailShowing = false
        inEditing = true
        tableView.reloadData()
        
        //make barbutton back to normal
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(unwindsegueback))
    }
    
    
    //selector to perform segue back after editing
    @objc func unwindsegueback(){
        //perform segue
        performSegue(withIdentifier: "unwindToPicker", sender: self)
    }
    
    
    // MARK: Model
    var recipe : Recipe?
    
    //placeholder for the recipe before put into model
    var name : String?
    var images = [UIImage]()
    var ingredients = [String]()
    var steps = [String]()
    lazy var recipe_Type : String? = {
        recipeType.first?.name
    }()
    
    
    
    
    
    
    let imagePicker = UIImagePickerController()
    
    // in collection view 
    @IBAction func addImageButtonClicked(_ sender: Any) {
        
        print("dsd")
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    

    
    
    
    //MARK: ImagePicker delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            images.append(pickedImage)
            
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ImageTableViewCell
            cell?.collectionView.reloadData()
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Collection View data source functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inDetailShowing == true {
            return images.count
        }else{
            return (images.count) + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if inDetailShowing == true{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
              cell.layer.borderWidth = 1
              cell.layer.borderColor  = UIColor.black.cgColor
            cell.deleteButton.isHidden = true
                
            cell.imageView.image = images[(images.count - 1) - indexPath.row]
            

              return cell
        }else{
            
            if indexPath.item == 0{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addImageCell", for: indexPath)
                cell.layer.borderWidth = 1
                cell.layer.borderColor  = UIColor.black.cgColor
                
                return cell
                
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
                cell.layer.borderWidth = 1
                cell.layer.borderColor  = UIColor.black.cgColor
                
                cell.imageView.image = images[(images.count) - indexPath.row]
                
                cell.deleteButton.isHidden = false
                
                return cell
            }
        }
        
    }
    
    //just setting delegate for uicollection view
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.item != 0 {
            let cell = cell as? ImageCollectionViewCell
            cell?.delegete = self
        }
    }
    
    
    //MARK: TableView Data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return 1
        } else if section == 3{
            return inDetailShowing! ? ingredients.count :  (ingredients.count ) + 1
        }else{
            return inDetailShowing! ? steps.count : (steps.count) + 1
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        switch section {
        case 0:
            return "Images"
        case 1:
            return "Name"
        case 2:
            return "Recipe type"
        case 3:
            return "Ingredients"
        case 4:
            return "Cooking steps"
        default:
            return ""
        }
        
       
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 150
        default:
            return 50
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0{
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell",for: indexPath) as! ImageTableViewCell
            
            if inDetailShowing == true{
                imageCell.isUserInteractionEnabled = false
            }else{
                imageCell.isUserInteractionEnabled = true
            }
            
            imageCell.collectionView.reloadData()

            return imageCell
        }
            
        else if indexPath.section == 1{
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "NameCell",for: indexPath) as! NameTableViewCell
            nameCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            nameCell.nameTextField.text = name
            
            if inDetailShowing == true{
                nameCell.isUserInteractionEnabled = false
            }else{
                nameCell.isUserInteractionEnabled = true

            }
            
            return nameCell
        }
        else if indexPath.section == 2{
            let recipeTypeCell = tableView.dequeueReusableCell(withIdentifier: "recipeTypeCell",for: indexPath)
            recipeTypeCell.textLabel?.text = recipe_Type
            
            if inDetailShowing == true{
                recipeTypeCell.isUserInteractionEnabled = false
                recipeTypeCell.accessoryType = .none
                
            }else{
                recipeTypeCell.isUserInteractionEnabled = true
                recipeTypeCell.accessoryType = .disclosureIndicator
            }
            
            return recipeTypeCell
        }
        if indexPath.section == 3{
            
            if inDetailShowing == true{
                
                let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientItem", for: indexPath) as! IngredientsTableViewCell
                ingredientCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                ingredientCell.IngredientTextField.text = ingredients[indexPath.row]

                ingredientCell.isUserInteractionEnabled = false

                
                return ingredientCell
            }else{
                
                if indexPath.row == 0{
                    let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "addIngredientCell",for: indexPath)
                    return ingredientCell
                }else{
                    let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientItem", for: indexPath) as! IngredientsTableViewCell
                    ingredientCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                    ingredientCell.IngredientTextField.text = ingredients[indexPath.row - 1]
                    
                    ingredientCell.isUserInteractionEnabled = true

                    
                    return ingredientCell
                }
                
            }
        }
            
        else if indexPath.section == 4{
            
            if inDetailShowing == true{
                
                let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepItem", for: indexPath) as! CookingStepTableViewCell
                stepCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                stepCell.stepTextField.text = steps[indexPath.row]
                stepCell.stepCountLabel.text = "Step \(indexPath.row + 1): "
                
                stepCell.isUserInteractionEnabled = false
                return stepCell
                
            }else{
                
                if indexPath.row == 0{
                    let stepCell = tableView.dequeueReusableCell(withIdentifier: "addStepCell", for: indexPath)
                    return stepCell
                }else{
                    let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepItem", for: indexPath) as! CookingStepTableViewCell
                    stepCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                    stepCell.stepTextField.text = steps[indexPath.row - 1]
                    stepCell.stepCountLabel.text = "Step \(indexPath.row): "
                    
                    stepCell.isUserInteractionEnabled = true

                    
                    return stepCell
                }
            }
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addStepCell", for: indexPath)
        return cell
        
       
        
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 3:
            if indexPath.row == 0{
                ingredients.append("")
                tableView.reloadData()
            }
            
            
        case 4:
            if indexPath.row == 0{
                steps.append("")
                tableView.reloadData()
            }
        default:
            print("nahh")
        }
    }
    
    
    //probably better to put textfield delegate here also
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 0 else{
            return
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageTableViewCell
        

        
        //doesnt need row actually since only one row
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 3) && (indexPath.row != 0){
            
            if editingStyle == .delete{
                
                ingredients.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
        }
        
        if (indexPath.section == 4) && (indexPath.row != 0){
            if editingStyle == .delete{
                steps.remove(at: indexPath.row - 1)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
        }
    }
    
    
    
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.resignFirstResponder()
        
        if segue.identifier == "recipeTypeDetail"{
            let destination = segue.destination as! RecipeTypeTableViewController
            destination.recipeType = self.recipeType
            destination.delegate = self
        }
        
        if segue.identifier == "unwindToPicker"{
            
            let imageData = images.map{ $0.jpegData(compressionQuality: 0.6)! }
            print(imageData)
            
            recipe = Recipe(title:  name ?? "" , images: imageData, ingredients: ingredients, steps: steps, recipteType:recipe_Type)
            
            
            delegate?.addRecipe(newRecipe: recipe!,section: sectionInModel,row : indexInModel, inEditing: inEditing!)
            
        }

        


    }
    

    
    
    
}


// MARK: RecipeTypeTVCDelegate

extension AddRecipeTableViewController: RecipeTypeTVCDelegate{
    func updateType(recipeType type: String) {
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.textLabel?.text = type
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.isSelected = false
        self.recipe_Type = type
    }
    
}


// MARK: ImageCollectionViewDelegate
extension AddRecipeTableViewController: PhotoCellDelegate{
    func delete(cell: ImageCollectionViewCell) {
        
        let tvc = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ImageTableViewCell
        
        if let indexPath = tvc?.collectionView.indexPath(for: cell){
            
            //delete model
            images.remove(at: indexPath.item - 1)
            
            //delete (probably better than reloadData()) 
            tvc?.collectionView.deleteItems(at: [indexPath])
        
        }
    }
    
    
}


//MARK: TextField Delegate
extension AddRecipeTableViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            textField.resignFirstResponder()
            return true
        }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var view : UIView = textField
        
        repeat{view = view.superview!} while !(view is UITableViewCell)
        
        let indexPath = self.tableView.indexPath(for: view as! UITableViewCell)
        
        switch indexPath?.section {
        case 1:
            self.name = textField.text!
        case 3:
            self.ingredients[indexPath!.row - 1] = textField.text ?? ""

        case 4:
            self.steps[indexPath!.row - 1] = textField.text ?? ""
        default:
            return
        }
        
        
    }
   
    
    
}
