//
//  Extension.swift
//  augmentedreality
//
//  Created by Andrew Carvajal on 7/30/18.
//  Copyright © 2018 Hoods. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom: Int {
    case undefined
    case phone
    case pad
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = max(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    static let isiPhoneSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone6or6Plusor6sor6sPlusor7or8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667
    static let isiPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone7Plusor8Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812.0
    static let iPadPro10 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 834.0
    static let iPadMiniorAir2orPro9 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024.0
    static let iPadPro12 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1366.0
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

public extension Float {
    
    public static func random() -> Float {
        return Float(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(_ min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}

