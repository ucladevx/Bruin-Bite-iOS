//
//  ItemDetailViewController.swift
//  Dont Eat Alone
//
//  Created by Ayush Patel on 2/28/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import UIKit
import WebKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var menuItem: Item?
    let nutritionBoxURL = "https://api.bruin-bite.com/api/v1/menu/nutritionbox?recipe_link="
    
    @IBOutlet weak var ingredientsBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.isScrollEnabled = false
        webView.isUserInteractionEnabled = false
        self.view.backgroundColor = UIColor.twilightBlue
        ingredientsBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = self.menuItem?.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var recipeID = ""
        if let item = menuItem {
            recipeID = extractRecipeIDFromRecipeURL(recipeURL: (item.recipeLink) ?? "") // TODO: hopefully, handle empty RecipeID
        }
        if let url = URL(string: nutritionBoxURL + recipeID) {
            let urlRequest: URLRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }

        let textView = UITextView(frame: CGRect(x: 10, y: 10, width: 395, height: 165)); // TODO: Add Constraints
        textView.isEditable = false
        textView.backgroundColor = UIColor.white
        
        
        let boldAttrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let normalAttrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Regular", size: 12)!]
        let attributedString = NSMutableAttributedString(string: "Ingredients: ", attributes:boldAttrs)
        attributedString.append(NSAttributedString(string: (menuItem?.ingredients) ?? "Error fetching ingredients.", attributes: normalAttrs))
        attributedString.append(NSMutableAttributedString(string: "\n\nAllergens: ", attributes:boldAttrs))
        let allergyString = buildAllergenString(allergies: (menuItem?.allergies))
        attributedString.append(NSMutableAttributedString(string: allergyString, attributes: normalAttrs))
        textView.attributedText = attributedString
        
        ingredientsBar.addSubview(textView)
        
        // Add constraints to textView
        textView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(ingredientsBar).offset(20)
            make.left.equalTo(ingredientsBar).offset(20);
            make.bottom.equalTo(ingredientsBar).offset(-20)
            make.right.equalTo(ingredientsBar).offset(-20);
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func extractRecipeIDFromRecipeURL(recipeURL: String) -> String {
        let constPrefixCount = "http://menu.dining.ucla.edu/Recipes/".count
        let index = recipeURL.index(recipeURL.startIndex, offsetBy: constPrefixCount)
        return String(recipeURL[index...]);
    }
    
    func buildAllergenString(allergies: [Allergen]?) -> String {
        guard let allergies = allergies else {
            return "Error loading allergens."
        }
        var allergyString: String = ""
        for allergen in allergies {
            if (allergen != Allergen.Vegan && allergen != Allergen.Vegetarian) {
                allergyString += allergen.rawValue + ", "
            }
        }
        if (allergyString.isEmpty) {
            return "None.";
        }
        let index = allergyString.index(allergyString.endIndex, offsetBy: -2)
        return String(allergyString[..<index])
    }


}
