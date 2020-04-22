//
//  NextViewController.swift
//  Wings
//
//  Created by 小川智也 on 2020/04/17.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import LTMorphingLabel
import Alamofire
import SwiftyJSON
import SDWebImage
class NextViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{

    var titleArray = [String]()
    var urlStringArray = [String]()
    var urlToImageArray = [String]()
    var changeColor = ChangeColor()
    var passedCountry = ""
    var parser = XMLParser()
    var currentElementName:String!
    var newsItems = [NewsItems]()
    var gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = changeColor.changeColor(topR: 0.54, topG: 0.13, topB: 0.86, topAlpha: 1.0, bottomR: 0.14, bottomG: 0.74, bottomB: 0.44, bottomAlpha: 0.43)
        //        全体
        gradientLayer.frame = view.bounds
        //        レイヤーを使うときはこれを使う
        view.layer.insertSublayer(gradientLayer, at: 0)
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let newsLabel2 = cell.viewWithTag(1) as! LTMorphingLabel
        let newsImage = cell.viewWithTag(2) as! UIImageView
        let newsImageString = URL(string: self.urlToImageArray[indexPath.row] as String)!
        newsLabel2.text = self.titleArray[indexPath.row]
        newsLabel2.morphingEffect = .sparkle
        newsImage.sd_setImage(with: newsImageString, completed: nil)
        cell.backgroundColor = .clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let webViewController = WebViewController()
        let url = urlStringArray[indexPath.row]
        UserDefaults.standard.set(url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
    }

    func getData(){
        
        var text = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ba7b7261340c46a19806aec59a11ce74"
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            print(response)
            switch response.result{
                
            case .success:
                for i in 0...10{
                    let json:JSON = JSON(response.data as Any)
                    let title = json["articles"][i]["title"].string
                    let urlString = json["articles"][i]["url"].string
                    let urlToImage = json["articles"][i]["urlToImage"].string
                    self.titleArray.append(title!)
                    self.urlStringArray.append(urlString!)
                    self.urlToImageArray.append(urlToImage!)
                }
                break
                
                
            case .failure(let error):
                print(error)
                break
            }
            self.tableView.reloadData()
            
        }
    }
}
