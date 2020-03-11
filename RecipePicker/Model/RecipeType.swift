//
//  Recipe.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import Foundation

struct RecipeType:Codable{
    var name : String
    var recipe : [Recipe] = []
    
    init(name : String) {
        self.name = name
    }
}

class RecipeParser : NSObject{
    
    var xmlParser : XMLParser?
    var recipeName : [RecipeType] = []
    var xmlText = ""
    var currentRecipe: RecipeType?
    
    init(withXML xml : String) {
        if let data = xml.data(using: .utf8){
            xmlParser = XMLParser(data : data)
        }
    }
    
    func parse()->[RecipeType]{
        xmlParser?.delegate = self
        xmlParser?.parse()
        return recipeName
    }
}


extension RecipeParser : XMLParserDelegate{
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //for every new element reset the text

        xmlText = ""
        if elementName == "recipe"{
            currentRecipe = RecipeType(name: "")
        }
    }
    
    //when reach the end node
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "name"{
           
            currentRecipe?.name = xmlText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
        
        //no need '/'
        if elementName == "recipe"{
            if let recipe = currentRecipe{
                recipeName.append(recipe)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
    
    
    public static func parserCall()->[RecipeType]{
        
        var recipes : [RecipeType] = []
        
        do{
            if let xmlUrl = Bundle.main.url(forResource: "recipetypes", withExtension: "xml"){
                let xml = try String(contentsOf: xmlUrl)
                let gameParser = RecipeParser(withXML: xml)
                let recipesType = gameParser.parse()
                
                for recipe in recipesType{
                    recipes.append(recipe)
                }
            }else{
                
                print("No available xml file")
                
            }
        }catch{
            print(error)
        }
        
        return recipes
        
    }

        
    

}




