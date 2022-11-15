//
//  RecipeViewController.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import UIKit


class RecipeViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var searchTextField:UITextField!
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var notFoundView: UIView!
    
    @IBOutlet weak var filterCollectionView:UICollectionView!
    @IBOutlet weak var listTableView:UITableView!
    private var recipeViewModel : RecipeViewModel!
    var filters = [
        ["key":"","value":"All"],["key":"vegan","value":"VEGAN"],
        ["key":"keto-friendly","value":"Keto"] , ["key":"low-sugar","value":"Low Sugar"]
    ]
    
    var selected_filter = ""
    var searchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Recipe Search"
        setDelegate()
        self.recipeViewModel =  RecipeViewModel()
        
        setBinder()
        
        // Do any additional setup after loading the view.
    }
    private func setDelegate() {
        listTableView.register(recipeTableViewCell.nib(), forCellReuseIdentifier: recipeTableViewCell.cellIdentifier)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.estimatedRowHeight = 100
        self.listTableView.rowHeight = UITableView.automaticDimension
        
        self.filterCollectionView.register(filterCollectionViewCell.nib(), forCellWithReuseIdentifier: filterCollectionViewCell.cellIdentifier)
        self.filterCollectionView.delegate = self
        self.filterCollectionView.dataSource = self
        self.filterCollectionView.reloadData()
    }
    private func setBinder(){
        recipeViewModel.recipeList.bind{
            [weak self ](list) in
            if let list = list {
                
                self?.listTableView.reloadData()
                if list.recipes.isEmpty {
                    self!.setView(view: self!.notFoundView, hidden: false)
                }else{
                    self!.setView(view: self!.notFoundView, hidden: true)
                }
            }
        }
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    
    
    
    func pushTableToTop(){
        //first check if there exist data in the list
        if self.recipeViewModel.recipeList.value?.recipes.count ?? 0 > 0 {
            let indexPath = IndexPath(row: 0, section: 0)
            self.listTableView.scrollToRow(at: indexPath, at: .top, animated: true)

        }
    }
    @IBAction func searchAction(_ sender: Any) {
        let searchfield = (searchTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        searchText = searchfield
        guard searchfield != "" else {return}

        self.recipeViewModel.getreciepeData(filter: selected_filter, search: searchText)
        // push table to the top after search
        pushTableToTop()
    }
 
}


//collectionFilterView
extension RecipeViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCollectionViewCell.cellIdentifier, for: indexPath) as! filterCollectionViewCell
        let item  = filters[indexPath.row]
        cell.configure(with: item["value"] ?? "" , selected: (selected_filter == item["key"]  ?? "" ))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item  = filters[indexPath.row]
        let key = item["key"]  ?? ""
        
    //    selected_filter = (key == selected_filter ) ?  "": key
        selected_filter = key
        
        
        self.recipeViewModel.getreciepeData(filter: selected_filter, search: searchText)
        // to push table to the top after refilter the data
        pushTableToTop()

        self.filterCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // dataArary is the managing array for your UICollectionView.
        let item  = filters[indexPath.row]
        guard let value = item["value"] else{ return CGSize(width: 0, height: 0)}
        let label = UILabel(frame: CGRect.zero)
        label.text = value
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 40)
    }
    
}
// for adjusting tableview
extension RecipeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeViewModel.recipeList.value?.recipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeTableViewCell.cellIdentifier) as! recipeTableViewCell
        
        guard let item = recipeViewModel.recipeList.value?.recipes[indexPath.row] as? Recipe ?? nil else { return cell }
        cell.configure(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = recipeViewModel.recipeList.value?.recipes[indexPath.row] as? Recipe ?? nil else { return  }
        let showDetail = mainStoryBoard.instantiateViewController(withIdentifier: "recipeDetailViewController") as! recipeDetailViewController
        showDetail.recipe.value = item
        self.navigationController?.pushViewController(showDetail, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // check if the user go to last cell to reload the next page .
        if indexPath.row == (recipeViewModel.recipeList.value?.recipes.count ?? 0) - 1 {
            guard let nextUrl = recipeViewModel.recipeList.value?.nextUrl else {return}
            
            if nextUrl != "" {
                recipeViewModel.recipeDataLoadMore(url: nextUrl)
            }
                
        }
    }
    
}
