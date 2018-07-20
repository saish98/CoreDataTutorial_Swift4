//
//  HomeViewCell.swift
//  CoreDataTutorial
//
//  Created by Heady on 20/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var imageViewHome: UIImageView!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelBed: UILabel!
    @IBOutlet weak var labelBath: UILabel!
    @IBOutlet weak var labelSqft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewHome.layer.cornerRadius = 4
        imageViewHome.layer.borderColor = UIColor.black.cgColor
        imageViewHome.layer.borderWidth = 1
        imageViewHome.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configureCell(homeObj: Home) {
        labelCity.text = homeObj.city
        labelCategory.text = homeObj.homeType
        labelBed.text = String(homeObj.bed)
        labelBath.text = String(homeObj.bath)
        labelSqft.text = String(homeObj.sqft)
        labelPrice.text = homeObj.price.currencyFormatter
        
        if let imageData = homeObj.image {
            imageViewHome.image = UIImage(data:imageData as Data)
        }
    }
}
