//
//  HistoryCell.swift
//  CoreDataTutorial
//
//  Created by Heady on 26/07/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var soldDateLabel: UILabel!
    @IBOutlet weak var soldPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(_ saleHistoryObj: SaleHistory) {
        soldDateLabel.text = saleHistoryObj.soldDate?.ToString
        soldPriceLabel.text = saleHistoryObj.soldPrice.currencyFormatter
    }
}
