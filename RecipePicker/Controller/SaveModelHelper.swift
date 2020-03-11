//
//  SaveModelHelper.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 11/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import Foundation

class SaveModelHelper {
    
    
    public static func load(numberOf data : Int)->[[Int : [Recipe]]]{
        
        let decoder = JSONDecoder()
        
        var returnData = [[Int:[Recipe]]]()
        
        
        for i in 0..<data{
            if let data = UserDefaults.standard.data(forKey: "data\(i)"){
            do{
                try returnData.append(decoder.decode(Dictionary<Int,[Recipe]>.self, from: data))
            }catch{
                print("error : \(error.localizedDescription)")
            }
        }
        
        
        }
        
        return returnData

    }
    
    public static func save(data : [Int:[Recipe]])->Bool{
        
        let encoder = JSONEncoder()
       
        if let encoded = try? encoder.encode(data){
            UserDefaults.standard.set(encoded, forKey: "data\(data.keys.first!)")
            return true
        }
        
        return false
    }
}
