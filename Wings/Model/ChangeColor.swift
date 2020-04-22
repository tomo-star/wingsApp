//
//  ChangeColor.swift
//  Wings
//
//  Created by 小川智也 on 2020/04/17.
//  Copyright © 2020 小川智也. All rights reserved.
//

import Foundation
import UIKit

class ChangeColor{
    func changeColor(topR:CGFloat,topG:CGFloat,topB:CGFloat,topAlpha:CGFloat,bottomR:CGFloat,bottomG:CGFloat,bottomB:CGFloat,bottomAlpha:CGFloat)->CAGradientLayer{
        
        let topColor = UIColor(red: topR, green: topR, blue: topB, alpha: topAlpha)
        
        let bottomColor = UIColor(red: bottomR, green: bottomG, blue: bottomB, alpha: bottomAlpha)
        
        let gradientColor = [topColor.cgColor,bottomColor.cgColor]
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColor
        
        return gradientLayer
        
    }
}
