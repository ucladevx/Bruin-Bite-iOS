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
    let nutritionBoxURL = "https://api.ucla-eats.com/api/v1/menu/nutritionbox?recipe_link="
    
    @IBOutlet weak var ingredientsBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.isScrollEnabled = false
        self.view.backgroundColor = UIColor.deaScarlet
        ingredientsBar.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let recipeID = extractRecipeIDFromRecipeURL(recipeURL: (menuItem?.recipeLink!)!) // TODO: hopefully, handle empty RecipeID
        if let url = URL(string: nutritionBoxURL + recipeID) {
            let urlRequest: URLRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }

        let textView = UITextView(frame: CGRect(x: 10, y: 10, width: 395, height: 165)); // TODO: Add Constraints
        textView.isEditable = false;
        
        
        let boldAttrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let normalAttrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Regular", size: 12)!]
        var attributedString = NSMutableAttributedString(string: "Ingredients: ", attributes:boldAttrs)
        attributedString.append(NSAttributedString(string: (menuItem?.ingredients)!, attributes: normalAttrs))
        attributedString.append(NSMutableAttributedString(string: "\n\nAllergens: ", attributes:boldAttrs))
        // TODO: Figure out a way to display allergens as a string and then display that instead of ingredients twice
        attributedString.append(NSMutableAttributedString(string: (menuItem?.ingredients)!, attributes: normalAttrs))
        textView.attributedText = attributedString
        ingredientsBar.addSubview(textView)
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


}
