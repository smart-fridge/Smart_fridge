//
//  ViewController.swift
//  SmartFridge2
//
//  Created by Mannan Mendiratta on 1/26/19.
//  Copyright © 2019 Mannan Mendiratta. All rights reserved.
//

import UIKit

struct Items {
    var id : Int
    var title : String
    var text : Int
    var image : String
}

class collectionViewCell: UICollectionViewCell{
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    func displayContent(image: UIImage, title: String){
        itemImage.image = image
        itemTitle.text = title
    }
}
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    @IBOutlet weak var LeadingS: NSLayoutConstraint!
    @IBOutlet weak var LeadingV: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var timer = Timer()
    var hamburgerMenuIsVisible = false
    //var data:[Items] = [Items(id: 1, title: "Apple", text: 100, image: "Apple"),Items(id: 2, title: "Banana", text: 50, image: "Banana"),Items(id: 3, title: "Cantaloupe", text: 0, image: "Cantaloupe")]
    var data:[Items] = []
    
    @IBAction func hamburberBtnTapped(_ sender: Any) {
        if !hamburgerMenuIsVisible{
            LeadingS.constant = 0
            LeadingV.constant = 0
        }
        else{
            LeadingS.constant = -200
            LeadingV.constant = -200
        }
        hamburgerMenuIsVisible = !hamburgerMenuIsVisible
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        self.title = "Smart Fridge"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        data = getData()
        scheduledTimerWithTimeInterval()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        data = getData()
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! collectionViewCell
        let item = data[indexPath.row]
        //cell.displayContent(image: UIImage(named: item.image), title: item.title)
        cell.itemImage?.image = UIImage(named: item.image)
        cell.itemTitle?.text = item.title
        return cell
    }
    
    func getData()->[Items]{
        var data:[Items] = []
        if let url = URL(string: "https://smart-fridge-229818.appspot.com/data") {
            do {
                print("Howdy")
                let contents = try String(contentsOf: url)
                let d = contents.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: d, options : .allowFragments) as? [Dictionary<String,String>]
                    {
                        // use the json here
                        for jsonString in jsonArray{
                            let temp:Items = Items(id: 1, title: jsonString["id2"] ?? "nil", text: Int(jsonString["value"] ?? "nil") ?? 0, image: jsonString["id2"] ?? "nil")
                            data.append(temp)
                            collectionView.reloadData()
                            
                        }
                        return data
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailView:DetailViewController = segue.destination as?DetailViewController{
            do{
                let selectedItem = collectionView.indexPathsForSelectedItems!
                detailView.setText(t: data[selectedItem[0].row].image, u: data[selectedItem[0].row].text)
            }
        }
        else if let RecipeView:RecipeViewController = segue.destination as? RecipeViewController{
            do{
                RecipeView.data = data
            }
        }
        
    }
    
}

