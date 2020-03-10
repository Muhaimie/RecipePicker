//
//  RecipeTypeTableViewController.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

protocol RecipeTypeTVCDelegate {
    func updateType(recipeType type : String)
}


class RecipeTypeTableViewController: UITableViewController {
    
    
    //delegate
    var delegate : RecipeTypeTVCDelegate?
    
    //data from last segue
    var recipeType : [RecipeType]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeType!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recipeType![indexPath.row].name

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = recipeType![indexPath.row].name
        delegate?.updateType(recipeType: selectedRow)
        self.dismiss(animated: true) {
        
           
        }
    }
 }
