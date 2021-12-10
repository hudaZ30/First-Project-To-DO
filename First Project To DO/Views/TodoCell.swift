//
//  TodoCell.swift
//  First Project To DO
//
//  Created by Tim on 23/04/1443 AH.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todoImagView: UIImageView!
    @IBOutlet weak var todoDateLabel: UILabel!
    @IBOutlet weak var todoTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

