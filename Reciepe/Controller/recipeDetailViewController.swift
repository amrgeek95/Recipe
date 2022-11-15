//
//  recipeDetailViewController.swift
//  Reciepe
//
//  Created by Mac on 14/11/2022.
//

import UIKit
import SDWebImage
class recipeDetailViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var iconImg: UIImageView!

    let recipe:Box<Recipe> = Box(nil)
    @IBOutlet weak var recipeBtn: UIButtonX!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBinding()
        self.setUI()
        // Do any additional setup after loading the view.
    }
    func setUI(){
        // navigation title
        self.navigationItem.title = "Recipe detail"
        self.navigationItem.backButtonTitle = ""

        
        
        let shareIcon = UIImage(systemName: "square.and.arrow.up")

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareIcon, style: .plain, target: self, action: #selector(shareAction(sender:)))
    }
    @objc func shareAction(sender:UIBarButtonItem){
        guard let shareLinkString = recipe.value?.url else {return}

        let shareLink = NSURL(string:shareLinkString)
        let activityViewController = UIActivityViewController(activityItems: [shareLink], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)

        
    }
    
    func setBinding(){
    
        recipe.bind{
            [weak self] (item) in
            
            self?.titleLabel.text = item?.label
            self!.iconImg.sd_setImage(with: URL(string: item!.image), placeholderImage: UIImage(named: "loading"))
            var ingredients = ""
            guard let ingredientsItem = item?.ingredientLines else { return }
            for ingredient in ingredientsItem {
                ingredients += "* \(ingredient) .\n"
            }
            self?.ingredientLabel.text = ingredients

        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        guard let shareLink = recipe.value?.url else {return}
        
        if let url = URL(string: shareLink) {
            UIApplication.shared.open(url)
        }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
