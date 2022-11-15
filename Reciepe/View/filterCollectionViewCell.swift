//
//  filterCollectionViewCell.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import UIKit

class filterCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var nameLabel :UILabel!
    @IBOutlet weak var containerView :UIView!
    var filterSelected :Bool = false
    static let cellIdentifier = "filterCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib {
       return  UINib(nibName: cellIdentifier, bundle: nil)
    }
    public func configure (with filter:String , selected:Bool){
        self.nameLabel.text = filter
        if selected ==  true{
            self.containerView.backgroundColor = UIColor.systemTeal
            self.nameLabel.textColor = UIColor.white
        }else{
            self.containerView.backgroundColor = UIColor.white
            self.nameLabel.textColor = UIColor.systemTeal
        }
    }

    
    
}
