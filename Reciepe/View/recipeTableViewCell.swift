//
//  recipeTableViewCell.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import UIKit
import SDWebImage
class recipeTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel :UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImg: UIImageView!
    static let cellIdentifier = "recipeTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
       return  UINib(nibName: cellIdentifier, bundle: nil)
    }
    public func configure (with recipe:Recipe){
        self.nameLabel.text = recipe.label
        self.iconImg.sd_setImage(with: URL(string: recipe.image), placeholderImage: UIImage(named: "loading"))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
