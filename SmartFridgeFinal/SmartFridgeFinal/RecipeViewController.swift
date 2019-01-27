//
//  RecipeViewController.swift
//  SmartFridgeFinal
//
//  Created by Mannan Mendiratta on 1/27/19.
//  Copyright © 2019 Mannan Mendiratta. All rights reserved.
//

import UIKit
struct Rec:Codable{
    let count: Int
    
    let recipes: [Recipe]
    
    enum CodingKeys : String, CodingKey {
        case count = "count"
        case recipes = "recipes"
    }
}
struct Recipe:Codable{
    let publisher:String
    let f2f_url:URL
    let title:String
    let source_URL:String
    let recipe_id:String
    let image_url:URL
    let social_rank:Double
    let publisher_url:URL
}
struct Recipe2{
    let title:String
}
class RecipeViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = recipe[indexPath.row].title
        return cell
    }
    
    
    

    @IBOutlet weak var tableView: UITableView!
    var data:[Items] = []
    var recipe:[Recipe2] = []
    var key = "3df8d959bf6a7afd2085a8de49e91f93"
    var q:String = "butter"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        recipe = getRecipeData()
        // Do any additional setup after loading the view.
    }
    func getRecipeData()->[Recipe2]{
        for i in 5..<data.count{
            if data[i].text>25{
                q+="," + data[i].title
            }
        }
        print(q)
        if let url = URL(string: "https://smart-fridge-229818.appspot.com/recipies") {
            do {
                print("Howdy")
                let contents = try String(contentsOf: url)
                print(contents)
                let d = contents.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: d, options : .allowFragments) as? Dictionary<String,Any>
                    {
                        // use the json here
                        let recipes = jsonArray["recipes"] as! [Dictionary<String,Any>]
                        for recipe1 in recipes {
                            let temp:Recipe2 = Recipe2(title: recipe1["title"] as! String)
                            recipe.append(temp)
                            
                        }
                        return recipe
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                //print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        return []
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
