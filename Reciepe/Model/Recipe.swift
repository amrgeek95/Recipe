// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }

import Foundation

// MARK: - Welcome
struct Result: Codable {
    var nextUrl: String
    var recipes: [Recipe]
   
    init(data:[Recipe],url:String){
        recipes = data
        nextUrl = url
    }
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    init(data: [String: Any]) {
        uri = data["uri"] as? String ?? ""
        label = data["label"] as? String ?? ""
        image = data["image"] as? String ?? ""
        url = data["url"] as? String ?? ""
        ingredientLines = data["ingredientLines"] as? [String] ?? []
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcomeLinks { response in
//     if let welcomeLinks = response.result.value {
//       ...
//     }
//   }

