//
//  RecipeViewModel.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import Foundation

class RecipeViewModel : NSObject {
    
 //   private var apiService : APIService!
    var recipeList:Box<Result> = Box(nil)
   // var nextUrl:Box<[Recipe]> = Box(nil)

    
    
    
    var bindRecipeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        getreciepeData()
    }
    
    
    func getreciepeData(filter:String = "", search:String = "") {
        let apiService  = APIService()
        var url = ""
        var paramters = [String:Any]()
        if filter != "" {
            paramters["health"] = filter
        }else{
            url = "&health=keto-friendly&health=low-sugar&health=vegan"
        }
        if search != "" {
            paramters["q"] = search
        }
        
        self.recipeList.value = nil
        apiService.getRecipeList( url:url,parameters: paramters, completion:  { (result, error) in
            guard let data = result else {
                
                return self.recipeList.value = nil
            }
            
            self.recipeList.value = data
        })
    }

    func recipeDataLoadMore(url:String = "") {
        let apiService  = APIService()
        
        apiService.getRecipeList(url:"",parameters: [:],nextUrl: url, completion:  { (result, error) in
            guard let data = result else {return }
            
            var newResult = Result(data: self.recipeList.value!.recipes + data.recipes, url: data.nextUrl)
            //newRecipe.append(data.recipes)
            
            self.recipeList.value = newResult
        })
    }
}
