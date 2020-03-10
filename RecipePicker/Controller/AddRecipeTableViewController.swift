//
//  AddRecipeViewController.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

protocol AddRecipeDelegate {
    
    func addRecipe(newRecipe recipe : Recipe)
}


class AddRecipeTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
   //segue parser model from last vc
    var recipeType : [RecipeType]?
    
    
    var delegate : AddRecipeDelegate?
    
    
    //for editingPage
    var inEditing = false
    var indexInModel: Int?
    var sectionInModel : Int?
    var recipeToEdit : Recipe?
       

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "New Recipe"
        self.navigationItem.largeTitleDisplayMode = .never
        
        imagePicker.delegate = self
        
        
        if inEditing == true{
            
        }

    }
    
    // MARK: Model
    var recipe : Recipe?
    
    //placeholder for the recipe before put into model
    var name : String?
    var images = [UIImage]() // edit later
    var ingredients = [String]()
    var steps = [String]()
    
    
    
    
    
    
    
    let imagePicker = UIImagePickerController()
    
    // in collection view 
    @IBAction func addImageButtonClicked(_ sender: Any) {
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
        
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
            

              return cell
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
            return ingredients.count + 1
        }else{
            return steps.count + 1
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
            
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell",for: indexPath) as UITableViewCell
            

            return imageCell
        }
            
        else if indexPath.section == 1{
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "NameCell",for: indexPath) as! NameTableViewCell
            nameCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            return nameCell
        }
        else if indexPath.section == 2{
            let recipeTypeCell = tableView.dequeueReusableCell(withIdentifier: "recipeTypeCell",for: indexPath)
            return recipeTypeCell
        }
        if indexPath.section == 3{
            if indexPath.row == 0{
                let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "addIngredientCell",for: indexPath)
                return ingredientCell
            }else{
                let ingredientCell = tableView.dequeueReusableCell(withIdentifier: "ingredientItem", for: indexPath) as! IngredientsTableViewCell
                ingredientCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)

                return ingredientCell
            }

            
        }
            
        else if indexPath.section == 4{
            if indexPath.row == 0{
                let stepCell = tableView.dequeueReusableCell(withIdentifier: "addStepCell", for: indexPath)
                return stepCell
            }else{
                let stepCell = tableView.dequeueReusableCell(withIdentifier: "stepItem", for: indexPath) as! CookingStepTableViewCell
                stepCell.textFieldDelegate(dataSourceDelegate: self, forRow: indexPath.row)
                stepCell.stepCountLabel.text = "Step \(indexPath.row): "
                
                return stepCell
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
        if segue.identifier == "recipeTypeDetail"{
            let destination = segue.destination as! RecipeTypeTableViewController
            destination.recipeType = self.recipeType
            destination.delegate = self
        }
        
        
        //for unwind segue but use delegate instead
        if let _ = segue.destination as? RecipePickerTableViewController{
            
            let recipeType = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? RecipeTypeTableViewCell
            
            
            recipe = Recipe(title:  name ?? "", images: images, ingredients: ingredients, steps: steps, recipteType: recipeType?.textLabel?.text)
            delegate?.addRecipe(newRecipe: recipe!)

        }
        


    }
    

    
    
    
}


// MARK: RecipeTypeTVCDelegate

extension AddRecipeTableViewController: RecipeTypeTVCDelegate{
    func updateType(recipeType type: String) {
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.textLabel?.text = type
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.isSelected = false
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
            print(images)
        
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
            self.name = textField.text
        case 3:
            self.ingredients[indexPath!.row - 1] = textField.text ?? ""

        case 4:
            self.steps[indexPath!.row - 1] = textField.text ?? ""
        default:
            return
        }
        
        
    }
   
    
    
}
