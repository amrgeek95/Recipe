//
//  Constant.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import Foundation
import UIKit

 let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let app_id = "298292b6"
let app_key = "8d3d6ea1d584c76716e7ef894d62f181"
let sourcesURL = "https://api.edamam.com/api/recipes/v2?type=public&app_id=\(app_id)&app_key=\(app_key)&field=uri&field=label&field=image&field=url&field=ingredientLines"
