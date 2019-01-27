//
//  MatricViewController.swift
//  SmartFridge2
//
//  Created by Mannan Mendiratta on 1/27/19.
//  Copyright © 2019 Mannan Mendiratta. All rights reserved.
//

import UIKit


class MatricViewController: UIViewController {

    @IBOutlet weak var basicBarChart: basicBarChart!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let dataEntries = getData()
        basicBarChart.dataEntries = dataEntries
    }
    
    func getData()->[BarEntry]{
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var data:[BarEntry] = []
        if let url = URL(string: "https://smart-fridge-229818.appspot.com/data") {
            do {
                print("Howdy")
                let contents = try String(contentsOf: url)
                let d = contents.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: d, options : .allowFragments) as? [Dictionary<String,String>]
                    {
                        // use the json here
                        var i = 0
                        for jsonString in jsonArray{
                            let value = Int(jsonString["value"] ?? "nil") ?? 0
                            print(value)
                            let height: Float = Float(value)/100.0
                            
                            
                            data.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: jsonString["id2"] ?? "nil"))
                            i+=1
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
    /*func generateDataEntries() -> [BarEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [BarEntry] = []
        for i in 0..<20 {
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*i))
            result.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: formatter.string(from: date)))
        }
        return result
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
