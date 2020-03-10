//
//  ImageCollectionViewCell.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 10/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate{
    
    func delete(cell : ImageCollectionViewCell)
    
}

class ImageCollectionViewCell: UICollectionViewCell {
    
     var delegete : PhotoCellDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func deleteButtonDidTapped(_ sender : Any){
        
        delegete?.delete(cell: self)
    }
    
}
