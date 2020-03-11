//
//  RecipePickerTableViewController.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class RecipePickerTableViewController: UITableViewController{
    
  
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //notification for save data (can check AppDelegate)
        setupNotification()
        
        setupNavBar()
        
        recipeType = RecipeParser.parserCall()
        
        putIntoModel()
        
        
        
        
        
    }
    
    //MARK: Notification setup methods
    func setupNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(saveUserDefault), name: NSNotification.Name("SAVE_DATA"), object: nil)
    }
    
    @objc func saveUserDefault(){
        
        for i in 0..<recipeType.count{
            print(SaveModelHelper.save(data: [i : recipeType[i].recipe]))

        }
        
        print("saved")
        
        
    }
    
    
    // MARK: Model config
    
    //recipeType model
    var recipeType = [RecipeType]()
    
    
    // put into model
    func putIntoModel(){
        
        
        let modelLoad = SaveModelHelper.load(numberOf: recipeType.count)
    
        print(modelLoad.count)
        for i in 0 ..< modelLoad.count{
            
            let valueArray = modelLoad[i].values.first
            if valueArray != nil{
                recipeType[i].recipe += valueArray!
            }
            
          
        }

    }
  
    
    //navigation bar setup
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)

        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search recipe..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .default
        
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
    }
    
    //for the searchBar filtering
    var searchedResult  = [[Recipe]]()
    var searching = false


    
 
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        if searching == false{
        return recipeType.count
        }else{
            
            return searchedResult.count
            
        }
        
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if searching == false
            
        {
            switch section {
            case 0:
                return recipeType[0].recipe.count != 0 ? recipeType[0].name : nil
            case 1:
                return recipeType[1].recipe.count != 0  ? recipeType[1].name : nil
            case 2:
                return recipeType[2].recipe.count != 0  ? recipeType[2].name : nil
            case 3:
                return recipeType[3].recipe.count != 0  ? recipeType[3].name : nil
            case 4:
                return recipeType[4].recipe.count != 0  ? recipeType[4].name : nil
            default:
                return nil
            }
            
            
            
        }
        else{
            
            switch section {
            case 0:
                return searchedResult[0].count != 0 ? recipeType[0].name : nil
            case 1:
                return searchedResult[1].count != 0 ? recipeType[1].name : nil
            case 2:
                return searchedResult[2].count != 0 ? recipeType[2].name : nil
            case 3:
                return searchedResult[3].count != 0 ? recipeType[3].name : nil
            case 4:
                return searchedResult[4].count != 0 ? recipeType[4].name : nil
            default:
                return nil
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searching == false{
            return recipeType[section].recipe.count
        }else{
            
            switch section {
            case 0:
                return searchedResult[0].count
            case 1 :
                return searchedResult[1].count
            case 2:
                return searchedResult[2].count
            case 3:
                return searchedResult[3].count
            case 4:
                return searchedResult[4].count
            default:
                return 0
            }
            
        }
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        if searching == false{
            // Configure the cell...
            cell.textLabel?.text = recipeType[indexPath.section].recipe[indexPath.row].title
            
            return cell
        }else{
            cell.textLabel?.text = searchedResult[indexPath.section][indexPath.row].title
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let vc = storyboard?.instantiateViewController(identifier: "DetailTVC") as? AddRecipeTableViewController
        vc?.inDetailShowing = true
        vc?.recipeType = recipeType
        
        
        if searching == false{

            vc?.recipeToEdit = recipeType[indexPath.section].recipe[indexPath.row]
            vc?.sectionInModel = indexPath.section
            vc?.indexInModel = indexPath.row
            
        }else{
            
            let recipeIndex = recipeType[indexPath.section].recipe.indices.filter{
                
                return recipeType[indexPath.section].recipe[$0] == searchedResult[indexPath.section][indexPath.row]
                
            }.first
            vc?.recipeToEdit = recipeType[indexPath.section].recipe[recipeIndex!]
            vc?.sectionInModel = indexPath.section
            vc?.indexInModel = recipeIndex
            
            }
        
        vc?.delegate = self

        //recipeType[indexPath.section].recipe.remove(at: indexPath.row)

            self.navigationController?.pushViewController(vc!, animated:  true)


        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            recipeType[indexPath.section].recipe.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        
            saveUserDefault()
       
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
    
    
    
  
    func addRecipe(newRecipe recipe: Recipe, section: Int?, row: Int?, inEditing editing: Bool) {
        
        //this prevent from the controller to show in searching mode in picker tvc
            
            self.navigationItem.searchController?.searchBar.text = ""
        self.navigationItem.searchController?.searchBar.endEditing(true)
        self.searching = false
        
        

        if editing == true{
            
            //delete the data first and readding
            recipeType[section!].recipe.remove(at: row!)
            
        }
            
            for i in 0 ..< self.recipeType.count{
                if self.recipeType[i].name == recipe.recipteType!{
                    self.recipeType[i].recipe.append(recipe)
                    
                }
            }
            
            tableView.reloadData()
            
            saveUserDefault()
            
        
    }
    
    
    
    
    
}


// MARK: UINAVIGATION CONTROLLER
//extension UINavigationController{
//
//    open func customPushController(_ inViewControllers:[UIViewController], animated : Bool){
//        var stack = self.viewControllers
//        stack.append(contentsOf: inViewControllers)
//        self.setViewControllers(stack, animated: true)
//    }
//}


//MARK: UISearchBarDelegate
extension RecipePickerTableViewController:UISearchBarDelegate{
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        searchedResult.removeAll()
        
        searching = true
            
            
            for recipetype in  recipeType{
                let result = recipetype.recipe.filter{$0.title.prefix(searchText.count).lowercased() == searchText.lowercased()}
                searchedResult.append(result)
            }
       

        
         tableView.reloadData()
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        tableView.reloadData()
        
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
extension RecipePickerTableViewController:UISearchControllerDelegate{
    

}



