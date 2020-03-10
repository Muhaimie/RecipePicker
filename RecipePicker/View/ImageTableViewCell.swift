//
//  ImageTableViewCell.swift
//  RecipePicker
//
//  Created by Muhaimie Mazlah on 10/03/2020.
//  Copyright © 2020 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView:UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate : UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int){
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    

    
    

}
