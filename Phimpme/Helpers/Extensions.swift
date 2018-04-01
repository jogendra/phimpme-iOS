//
//  Extensions.swift
//  Phimpme
//
//  Created by JOGENDRA on 01/04/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {

    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }

    class func initialVC() -> UIViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "InitialViewController")
    }

    class func settingsVC() -> UIViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: "SettingsViewController")
    }
}

extension UIApplication {

    class func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

    func verticleAlignTextAndImage(withSpacing spacing: CGFloat) {
        let titleSize = titleLabel!.frame.size
        let imageSize = imageView!.frame.size

        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: -imageSize.width/2, bottom: 0, right: -titleSize.width)
    }

    func leftAlignedTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: 0)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}

extension UIColor {

    class var appThemeColor: UIColor {
        return  UIColor(rgb: 0x007ED0)
    }

    class var toastGreen: UIColor {
        return UIColor(rgb: 0x0C743B)
    }
    class var toastGray: UIColor {
        return UIColor(rgb: 0xAAAAAA)
    }

    class var grayText: UIColor {
        return UIColor(rgb: 0x111111)
    }

    class var grayLight: UIColor {
        return UIColor(rgb: 0xcacaca)
    }

    class var appWarmGrey: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }

    class var appLighterWarmGrey: UIColor {
        return UIColor(white: 151.0 / 255.0, alpha: 1.0)
    }

    class var appGreyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }

    class var appWhiteButNot: UIColor {
        return UIColor(red: 234.0 / 255.0, green: 233.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
    }

    class var iosRed: UIColor {
        return UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
    }

    class var iosOrange: UIColor {
        return UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1.0)
    }

    class var iosYellow: UIColor {
        return UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
    }

    class var iosGreen: UIColor {
        return UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0)
    }

    class var iosTealBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1.0)
    }

    class var iosBlue: UIColor {
        return UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
    }

    class var iosPurple: UIColor {
        return UIColor(red: 88/255, green: 66/255, blue: 214/255, alpha: 1.0)
    }

    class var iosPink: UIColor {
        return UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1.0)
    }

    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
