//
//  Recipe.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 09/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import Foundation
import UIKit

struct Recipe :Codable{
    var title: String
    var images : [Data]?
    var ingredients : [String]?
    var steps : [String]?
    var recipteType : String?
    
}

extension Recipe: Hashable{
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.title == rhs.title && lhs.images == rhs.images &&  lhs.ingredients == rhs.ingredients &&  lhs.steps == rhs.steps
    }

    func hash(into hasher: inout Hasher) {


        hasher.combine(title)
        hasher.combine(images)
        hasher.combine(ingredients)
        hasher.combine(steps)
        

    }

}
