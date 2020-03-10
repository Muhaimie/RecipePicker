//
//  RecipePickerTableViewController.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class RecipePickerTableViewController: UITableViewController,UISearchBarDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        recipeType = RecipeParser.parserCall()
        
        
        // later delete
        let recipe = Recipe(title: "aa", images: nil, ingredients: nil, steps: nil)
        recipeType[0].recipe.append(recipe)
        

    }
    
    
    
    // MARK: Model config
    
    //recipeType model
    var recipeType = [RecipeType]()
    
    
  
    
    //navigation bar setup
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return recipeType.count
    }

    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recipeType[section].name
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeType[section].recipe.count 
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recipeType[indexPath.section].recipe[indexPath.row].title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        
        let vc = storyboard?.instantiateViewController(identifier: "DetailTVC") as? AddRecipeTableViewController
        vc?.inEditing = true
        vc?.recipeToEdit = recipeType[indexPath.section].recipe[indexPath.row]
        vc?.sectionInModel = indexPath.section
        vc?.indexInModel = indexPath.row
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
        print(indexPath.row)
    }
    
    
  

    
   // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "addRecipe"{
            let detailTableVC = segue.destination as! AddRecipeTableViewController
            detailTableVC.recipeType  = self.recipeType
            detailTableVC.delegate = self
        }
    }
    
    //unwind segue
    @IBAction func unwindToRecipePicker(_ sender: UIStoryboardSegue){
        
    }

}



//MARK: AddRecipeDelegate
extension RecipePickerTableViewController:AddRecipeDelegate{
    
    func addRecipe(newRecipe recipe: Recipe) {

        for i in 0 ..< self.recipeType.count{
            if self.recipeType[i].name == recipe.recipteType!{
                self.recipeType[i].recipe.append(recipe)
                
            }
        }
        
        tableView.reloadData()
        //print(recipeType)
    }
    
    
}
