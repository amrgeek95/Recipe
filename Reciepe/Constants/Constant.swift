//
//  Constant.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import Foundation
import UIKit

 let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let app_id = "b08f19a2"
let app_key = "46e21ed917d1c46243aa767cde8bbd96"
let sourcesURL = "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(app_id)&app_key=\(app_key)&field=uri&field=label&field=image&field=url&field=ingredientLines"
