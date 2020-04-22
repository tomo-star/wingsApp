//
//  ViewController.swift
//  Wings
//
//  Created by 小川智也 on 2020/04/16.
//  Copyright © 2020 小川智也. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import LTMorphingLabel

class ViewController: UIViewController {

    @IBOutlet weak var sampleLabel: LTMorphingLabel!
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var adressLabel: UILabel!
    var timer: Timer?
    var index: Int = 0
    var gradientLayer = CAGradientLayer()
    var changeColor = ChangeColor()
    // 表示する文字リスト
    let textList = ["Tap The Country", "And Get to Know", "The Latest World"]
    
    var adressString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.layer.cornerRadius = 22.0
        sampleLabel.morphingEffect = .fall
        gradientLayer = changeColor.changeColor(topR: 0.64, topG: 0.10, topB: 0.56, topAlpha: 0.71, bottomR: 0.44, bottomG: 0.64, bottomB: 0.54, bottomAlpha: 0.73)
        //        全体
        gradientLayer.frame = view.bounds
        //        レイヤーを使うときはこれを使う
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        timer = Timer.scheduledTimer(timeInterval: 3.0,
                                     target: self,
                                     selector: #selector(updateLabel(timer:)), userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        timer?.invalidate()
    }
    
    @objc func updateLabel(timer: Timer) {
        sampleLabel.text = textList[index]

        index += 1
        if index >= textList.count {
            index = 0
        }
    }
    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began{
        }else if sender.state == .ended{
            let tapPoint = sender.location(in: view)
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            let lat = center.latitude
            let log = center.longitude
            convert(lat: lat, log: log)
        }
        
    }

            func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
                
                let geocoder = CLGeocoder()
                let location = CLLocation(latitude: lat, longitude: log)
                
                geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
                    
                    if let placeMark = placeMark{
                                    
                        if let pm = placeMark.first{
                            if pm.administrativeArea != nil || pm.locality != nil{
                    //                        ！は値がなかったらその先に行かない
                    //                        selfは上で宣言しているから必要
                                self.adressString = pm.country!
                            }else{
                                
                                self.adressString = pm.name!
                                            
                            }
                                self.adressLabel.text = self.adressString
                                        
                        }
                                    
                    }
            
    
}
}
    
    
}
