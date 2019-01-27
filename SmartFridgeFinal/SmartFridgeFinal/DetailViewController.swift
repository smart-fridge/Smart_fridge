//
//  DetailViewController.swift
//  SmartFridge2
//
//  Created by Mannan Mendiratta on 1/26/19.
//  Copyright © 2019 Mannan Mendiratta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var percentBar: UIProgressView!
    var imageText: String = ""
    var percentText: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        image?.image = UIImage(named: imageText)
        percent?.text = String(percentText) + "%"
        percentBar.progress = Float(Double(percentText)/100.0)
        if(percentText<25){
            percentBar.trackTintColor = UIColor.red
        }
        else if(percentText<75){
            percentBar.trackTintColor = UIColor.yellow
        }
        else{
            percentBar.trackTintColor = UIColor.green
        }
        
        let buttonX = 150
        let buttonY = 600
        let buttonWidth = 100
        let buttonHeight = 50
        
        let button = UIButton(type: .system)
        button.setTitle("Buy", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        self.view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    @objc func buttonClicked(sender : UIButton){
        //let alert = UIAlertController(title: "Baught", message: "You have baught the item", preferredStyle: .alert)
        
        /*self.present(alert, animated: true){
         alert.view.superview?.isUserInteractionEnabled = true
         alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
         }*/
        if let url = URL(string: "https://www.amazon.com/gp/aws/cart/add.html?ASIN.1=B00S5MSJTY&Quantity.1=2") {
            // fallback
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
    func setText(t:String,u:Int){
        imageText = t
        percentText = u
        print(u)
        if isViewLoaded{
            print("Hello")
            image?.image = UIImage(named: imageText)
            percent?.text = String(percentText)+"%"
            percentBar.progress = Float(Double(percentText)/100.0)
            if(percentText<25){
                percentBar.trackTintColor = UIColor.red
            }
            else if(percentText<75){
                percentBar.trackTintColor = UIColor.yellow
            }
            else{
                percentBar.trackTintColor = UIColor.green
            }
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
