//
//  APIService.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import Foundation
import Alamofire


class APIService {
    var completionHandler: (() -> Void)?
    
    var nextUrl:Box<String> = Box("")

    func getRecipeList(url:String,parameters : [String:Any], nextUrl:String = "" , completion: @escaping (Result? , _ error: Error?)->()) {
        
        
        let api_url = (nextUrl.isEmpty) ? "\(sourcesURL + url)":nextUrl
        let falseData = Result(data: [Recipe](), url: "")
        
        AF.request(api_url,method: .get, parameters: parameters).responseJSON {
            (response) in
            
            
            if let results = response.value as? [String:Any]{
                DispatchQueue.main.async {
                    
                    guard let hits = results["hits"] as? [[String:AnyObject]] else {return completion(falseData, nil) }
                    guard let link = results["_links"] as? [String:AnyObject] else {return completion(falseData, nil) }
                    guard let next = link["next"] as? [String:AnyObject] else {return completion(falseData, nil) }
                    
                    if let href =  next["href"] as? String {
                        completion(self.recipesListFrom(results: hits,href), nil)
                    }else{
                        completion(self.recipesListFrom(results: hits,""), nil)
                    }
                }
            }else{
                completion(nil, nil)

            }
        }
    }
    private func recipesListFrom(results: [[String: Any]],_ nextUrl:String = "") -> Result {
        var recipes = [Recipe]()
        
        for recipe in results {
            guard let recipeItem = recipe["recipe"] as? [String:Any] else {return Result(data: recipes, url: "")}
            recipes.append(Recipe(data: recipeItem))
        }
        
        return Result(data: recipes, url: nextUrl)
    }
    /*
     func apiToGetEmployeeData(completion : @escaping (Employees) -> ()){
     URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
     if let data = data {
     
     let jsonDecoder = JSONDecoder()
     
     let empData = try! jsonDecoder.decode(Employees.self, from: data)
     completion(empData)
     }
     }.resume()
     }
     */
}
