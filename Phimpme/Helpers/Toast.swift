//
//  Toast.swift
//  Phimpme
//
//  Created by JOGENDRA on 01/04/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

/*
 *  Infix overload method
 */
func /(lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
}

/*
 *  Toast Config
 */
let ToastDefaultDuration  =   2.0
let HRToastFadeDuration     =   0.2
let HRToastHorizontalMargin : CGFloat  =   10.0
let HRToastVerticalMargin   : CGFloat  =   10.0

let HRToastPositionDefault  =   "bottom"
let HRToastPositionTop      =   "top"
let HRToastPositionCenter   =   "center"

// activity
let HRToastActivityWidth  :  CGFloat  = 100.0
let HRToastActivityHeight :  CGFloat  = 100.0
let HRToastActivityPositionDefault    = "center"

// image size
let HRToastImageViewWidth :  CGFloat  = 80.0
let HRToastImageViewHeight:  CGFloat  = 80.0

// label setting
let HRToastMaxWidth       :  CGFloat  = 0.8;      // 80% of parent view width
let HRToastMaxHeight      :  CGFloat  = 0.8;
let HRToastFontSize       :  CGFloat  = 16.0
let HRToastMaxTitleLines              = 0
let HRToastMaxMessageLines            = 0

// shadow appearance
let HRToastShadowOpacity  : CGFloat   = 0.8
let HRToastShadowRadius   : CGFloat   = 6.0
let HRToastShadowOffset   : CGSize    = CGSize(width: CGFloat(4.0), height: CGFloat(4.0))

let HRToastOpacity        : CGFloat   = 0.8
let HRToastCornerRadius   : CGFloat   = 10.0

var HRToastActivityView: UnsafePointer<UIView>?    =   nil
var HRToastTimer: UnsafePointer<Timer>?          =   nil
var HRToastView: UnsafePointer<UIView>?            =   nil

/*
 *  Custom Config
 */
let HRToastHidesOnTap       =   true
let HRToastDisplayShadow    =   true

var yPositionOfToast: CGFloat = 0.0

//HRToast (UIView + Toast using Swift)

extension UIView {

    /*
     *  public methods
     */
    func makeToast(message msg: String) {
        //    self.makeToast(message: msg, duration: HRToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }

    func showToast(message msg: String) {
        self.makeToast(message: msg, duration: ToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }

    func makeToast(message msg: String, yPosition: CGFloat) {
        yPositionOfToast = yPosition
        self.makeToast(message: msg, duration: ToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject) {
        let toast = self.viewForMessage(msg, title: nil, image: nil)
        self.showToast(toast!, duration: duration, position: position)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String) {
        let toast = self.viewForMessage(msg, title: title, image: nil)
        self.showToast(toast!, duration: duration, position: position)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject, image: UIImage) {
        let toast = self.viewForMessage(msg, title: nil, image: image)
        self.showToast(toast!, duration: duration, position: position)
    }

    func makeToast(message msg: String, duration: Double, position: AnyObject, title: String, image: UIImage) {
        let toast = self.viewForMessage(msg, title: title, image: image)
        self.showToast(toast!, duration: duration, position: position)
    }

    func showToast(_ toast: UIView) {
        self.showToast(toast, duration: ToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }

    func showToast(_ toast: UIView, duration: Double, position: AnyObject) {
        let existToast = objc_getAssociatedObject(self, &HRToastView) as! UIView?
        if existToast != nil {
            if let timer = objc_getAssociatedObject(existToast, &HRToastTimer) as? Timer {
                timer.invalidate();
                self.hideToast(existToast!, force: false);
            }
        }

        toast.center = self.centerPointForPosition(position, toast: toast)
        toast.alpha = 0.0

        if (yPositionOfToast != 0.0) {
            toast.frame.origin.y = yPositionOfToast
            yPositionOfToast = 0.0
        }

        if HRToastHidesOnTap {
            let tapRecognizer = UITapGestureRecognizer(target: toast, action: #selector(UIView.handleToastTapped(_:)))
            toast.addGestureRecognizer(tapRecognizer)
            toast.isUserInteractionEnabled = true;
            toast.isExclusiveTouch = true;
        }

        self.addSubview(toast)
        objc_setAssociatedObject(self, &HRToastView, toast, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)

        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0, options: ([.curveEaseOut, .allowUserInteraction]),
                       animations: {
                        toast.alpha = 1.0
        },
                       completion: { (finished: Bool) in
                        let timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(UIView.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
                        objc_setAssociatedObject(toast, &HRToastTimer, timer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }

    func makeToastActivity() {
        self.makeToastActivity(position: HRToastActivityPositionDefault as AnyObject)
    }

    func makeToastActivityWithMessage(message msg: String){
        self.makeToastActivity(position: HRToastActivityPositionDefault as AnyObject, message: msg)
    }

    func makeToastActivity(position pos: AnyObject, message msg: String = "") {
        let existToast = objc_getAssociatedObject(self, &HRToastView) as! UIView?
        if existToast != nil {
            if let timer = objc_getAssociatedObject(existToast, &HRToastTimer) as? Timer {
                timer.invalidate();
                self.hideToast(existToast!, force: false);
            }
        }

        let existingActivityView: UIView? = objc_getAssociatedObject(self, &HRToastActivityView) as? UIView
        if existingActivityView != nil { return }

        let activityView = UIView(frame: CGRect(x: 0, y: 0, width: HRToastActivityWidth, height: HRToastActivityHeight))
        activityView.center = self.centerPointForPosition(pos, toast: activityView)
        activityView.backgroundColor = UIColor.black.withAlphaComponent(HRToastOpacity)
        activityView.alpha = 0.0
        activityView.autoresizingMask = ([.flexibleLeftMargin, .flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin])
        activityView.layer.cornerRadius = HRToastCornerRadius

        if HRToastDisplayShadow {
            activityView.layer.shadowColor = UIColor.black.cgColor
            activityView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            activityView.layer.shadowRadius = HRToastShadowRadius
            activityView.layer.shadowOffset = HRToastShadowOffset
        }

        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicatorView.center = CGPoint(x: activityView.bounds.size.width / 2, y: activityView.bounds.size.height / 2)
        activityView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()

        if (!msg.isEmpty){
            activityIndicatorView.frame.origin.y -= 10
            let activityMessageLabel = UILabel(frame: CGRect(x: activityView.bounds.origin.x, y: (activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + 10), width: activityView.bounds.size.width, height: 20))
            activityMessageLabel.textColor = UIColor.white
            activityMessageLabel.font = (msg.characters.count<=10) ? UIFont(name:"Roboto-Light", size: 14) : UIFont(name:"Roboto-Light", size: 13)
            activityMessageLabel.textAlignment = .center
            activityMessageLabel.text = msg
            activityView.addSubview(activityMessageLabel)
        }


        self.addSubview(activityView)

        // associate activity view with self
        objc_setAssociatedObject(self, &HRToastActivityView, activityView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        activityView.alpha = 1.0
        },
                       completion: nil)
    }

    func hideToastActivity() {
        let existingActivityView = objc_getAssociatedObject(self, &HRToastActivityView) as! UIView?
        if existingActivityView == nil { return }
        UIView.animate(withDuration: HRToastFadeDuration,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        existingActivityView!.alpha = 0.0
        },
                       completion: { (finished: Bool) in
                        existingActivityView!.removeFromSuperview()
                        objc_setAssociatedObject(self, &HRToastActivityView, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        })
    }

    /*
     *  private methods (helper)
     */
    func hideToast(_ toast: UIView) {
        self.hideToast(toast, force: false);
    }

    func hideToast(_ toast: UIView, force: Bool) {
        let completeClosure = { (finish: Bool) -> () in
            toast.removeFromSuperview()
            objc_setAssociatedObject(self, &HRToastTimer, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        if force {
            completeClosure(true)
        } else {
            UIView.animate(withDuration: HRToastFadeDuration,
                           delay: 0.0,
                           options: ([.curveEaseIn, .beginFromCurrentState]),
                           animations: {
                            toast.alpha = 0.0
            },
                           completion:completeClosure)
        }
    }

    @objc func toastTimerDidFinish(_ timer: Timer) {
        self.hideToast(timer.userInfo as! UIView)
    }

    @objc func handleToastTapped(_ recognizer: UITapGestureRecognizer) {
        //        var timer = objc_getAssociatedObject(self, &HRToastTimer) as! NSTimer
        //        timer.invalidate()
        //
        //        self.hideToast(toast: recognizer.view!)
    }

    func centerPointForPosition(_ position: AnyObject, toast: UIView) -> CGPoint {
        if position is String {
            let toastSize = toast.bounds.size
            let viewSize  = self.bounds.size
            if position.lowercased == HRToastPositionTop {
                return CGPoint(x: viewSize.width/2, y: toastSize.height/2 + HRToastVerticalMargin - 50)
            } else if position.lowercased == HRToastPositionDefault {
                return CGPoint(x: viewSize.width/2, y: viewSize.height - toastSize.height/2 - HRToastVerticalMargin - 50)
            } else if position.lowercased == HRToastPositionCenter {
                return CGPoint(x: viewSize.width/2, y: viewSize.height/2 - 50)
            }
        } else if position is NSValue {
            return position.cgPointValue
        }

        NSLog("Warning: Invalid position for toast.")
        return self.centerPointForPosition(HRToastPositionDefault as AnyObject, toast: toast)
    }

    func viewForMessage(_ msg: String?, title: String?, image: UIImage?) -> UIView? {
        if msg == nil && title == nil && image == nil { return nil }

        var msgLabel: UILabel?
        var titleLabel: UILabel?
        var imageView: UIImageView?

        let wrapperView = UIView()
        wrapperView.autoresizingMask = ([.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin])
        wrapperView.layer.cornerRadius = HRToastCornerRadius
        wrapperView.backgroundColor = UIColor.black.withAlphaComponent(HRToastOpacity)

        if HRToastDisplayShadow {
            wrapperView.layer.shadowColor = UIColor.black.cgColor
            wrapperView.layer.shadowOpacity = Float(HRToastShadowOpacity)
            wrapperView.layer.shadowRadius = HRToastShadowRadius
            wrapperView.layer.shadowOffset = HRToastShadowOffset
        }

        if image != nil {
            imageView = UIImageView(image: image)
            imageView!.contentMode = .scaleAspectFit
            imageView!.frame = CGRect(x: HRToastHorizontalMargin, y: HRToastVerticalMargin, width: CGFloat(HRToastImageViewWidth), height: CGFloat(HRToastImageViewHeight))
        }

        var imageWidth: CGFloat, imageHeight: CGFloat, imageLeft: CGFloat
        if imageView != nil {
            imageWidth = imageView!.bounds.size.width
            imageHeight = imageView!.bounds.size.height
            imageLeft = HRToastHorizontalMargin
        } else {
            imageWidth  = 0.0; imageHeight = 0.0; imageLeft   = 0.0
        }

        if title != nil {
            titleLabel = UILabel()
            titleLabel!.numberOfLines = HRToastMaxTitleLines
            titleLabel!.font = UIFont.boldSystemFont(ofSize: HRToastFontSize)
            titleLabel!.textAlignment = .center
            titleLabel!.lineBreakMode = .byWordWrapping
            titleLabel!.textColor = UIColor.white
            titleLabel!.backgroundColor = UIColor.clear
            titleLabel!.alpha = 1.0
            titleLabel!.text = title

            // size the title label according to the length of the text
            let maxSizeTitle = CGSize(width: (self.bounds.size.width * HRToastMaxWidth) - imageWidth, height: self.bounds.size.height * HRToastMaxHeight);
            let expectedHeight = title!.stringHeightWithFontSize(HRToastFontSize, width: maxSizeTitle.width)
            titleLabel!.frame = CGRect(x: 0.0, y: 0.0, width: maxSizeTitle.width, height: expectedHeight)
        }

        if msg != nil {
            msgLabel = UILabel();
            msgLabel!.numberOfLines = HRToastMaxMessageLines
            msgLabel!.font = UIFont.systemFont(ofSize: HRToastFontSize)
            msgLabel!.lineBreakMode = .byWordWrapping
            msgLabel!.textAlignment = .center
            msgLabel!.textColor = UIColor.white
            msgLabel!.backgroundColor = UIColor.clear
            msgLabel!.alpha = 1.0
            msgLabel!.text = msg

            let maxSizeMessage = CGSize(width: (self.bounds.size.width * HRToastMaxWidth) - imageWidth, height: self.bounds.size.height * HRToastMaxHeight)
            let expectedHeight = msg!.stringHeightWithFontSize(HRToastFontSize, width: maxSizeMessage.width)
            msgLabel!.frame = CGRect(x: 0.0, y: 0.0, width: maxSizeMessage.width, height: expectedHeight)
        }

        var titleWidth: CGFloat, titleHeight: CGFloat, titleTop: CGFloat, titleLeft: CGFloat
        if titleLabel != nil {
            titleWidth = titleLabel!.bounds.size.width
            titleHeight = titleLabel!.bounds.size.height
            titleTop = HRToastVerticalMargin
            titleLeft = imageLeft + imageWidth + HRToastHorizontalMargin
        } else {
            titleWidth = 0.0; titleHeight = 0.0; titleTop = 0.0; titleLeft = 0.0
        }

        var msgWidth: CGFloat, msgHeight: CGFloat, msgTop: CGFloat, msgLeft: CGFloat
        if msgLabel != nil {
            msgWidth = msgLabel!.bounds.size.width
            msgHeight = msgLabel!.bounds.size.height
            msgTop = titleTop + titleHeight + HRToastVerticalMargin
            msgLeft = imageLeft + imageWidth + HRToastHorizontalMargin
        } else {
            msgWidth = 0.0; msgHeight = 0.0; msgTop = 0.0; msgLeft = 0.0
        }

        let largerWidth = max(titleWidth, msgWidth)
        let largerLeft  = max(titleLeft, msgLeft)

        // set wrapper view's frame
        let wrapperWidth  = max(imageWidth + HRToastHorizontalMargin * 2, largerLeft + largerWidth + HRToastHorizontalMargin)
        let wrapperHeight = max(msgTop + msgHeight + HRToastVerticalMargin, imageHeight + HRToastVerticalMargin * 2)
        wrapperView.frame = CGRect(x: 0.0, y: 0.0, width: wrapperWidth, height: wrapperHeight)

        // add subviews
        if titleLabel != nil {
            titleLabel!.frame = CGRect(x: titleLeft, y: titleTop, width: titleWidth, height: titleHeight)
            wrapperView.addSubview(titleLabel!)
        }
        if msgLabel != nil {
            msgLabel!.frame = CGRect(x: msgLeft, y: msgTop, width: msgWidth, height: msgHeight)
            wrapperView.addSubview(msgLabel!)
        }
        if imageView != nil {
            wrapperView.addSubview(imageView!)
        }

        return wrapperView
    }

}

extension String {

    func stringHeightWithFontSize(_ fontSize: CGFloat,width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping;
        let attributes = [NSAttributedStringKey.font:font,
                          NSAttributedStringKey.paragraphStyle:paragraphStyle.copy()]

        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }

}
