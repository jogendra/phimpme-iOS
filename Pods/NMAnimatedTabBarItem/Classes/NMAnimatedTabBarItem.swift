//
//  NMAnimatedTabBarItem.swift
//  NMAnimatedTabBarItem
//
//  Created by Balu Naik on 3/20/18.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

@objc open class NMAnimateTabBarItem: NSObject {
    
    ///  Options for animating. Default transitionFlipFromRight
    open var transitionOptions: UIView.AnimationOptions = UIView.AnimationOptions.transitionFlipFromRight
    
    /// The duration of the animation. Default 0.5
    open var duration: CGFloat = 0.5
    
    /// Animation direction (left, right).
    open var direction: NMRotationDirection?
    
    /// Frame Animation array list
    @nonobjc open var animationImages: Array<CGImage> = Array()
    
    // MARK: NMAnimationKey constants
    
    struct NMAnimationKeys {
        static let Scale = "transform.scale"
        static let Rotation = "transform.rotation"
        static let KeyFrame = "contents"
    }
    
    @objc public func animateTabBarItem(_ tabBar:UITabBar,_ tabIndex:Int, _ repeatCount:Float, _ animationType:NMAnimationtype) {
        if let selectedItemImage : UIImageView = tabBar.subviews[tabIndex+1].subviews.first as? UIImageView {
            switch animationType {
            case NMAnimationtype.Bounce:
                self.playBounceAnimation(selectedItemImage, repeatCount)
            case NMAnimationtype.Rotation:
                self.playRotationAnimation(selectedItemImage, repeatCount)
            case NMAnimationtype.Transition:
                self.playTransitionAnimations(selectedItemImage)
            case NMAnimationtype.Frame:
                self.playFrameAnimation(selectedItemImage, repeatCount)
            default:
                break
            }
        } else {
             fatalError("tabbar item image not set")
        }
    }
    
    @objc public func createImagesArray(_ imageNames: Array<String>) {
        for name: String in imageNames {
            if let image = UIImage(named: name)?.cgImage {
                animationImages.append(image)
            }
        }
    }
    
    //MARK:- Private API
    
    fileprivate func playTransitionAnimations(_ icon: UIImageView) {
        UIView.transition(with: icon, duration: TimeInterval(duration), options: transitionOptions, animations: {
        }, completion: { _ in
        })
    }
    
    fileprivate func playRotationAnimation(_ icon: UIImageView, _ repeatCount:Float) {
        let rotate = CABasicAnimation(keyPath:NMAnimationKeys.Rotation)
        rotate.fromValue = 0.0
        var toValue = CGFloat.pi * 2
        if direction != nil && direction == NMRotationDirection.left {
            toValue = toValue * -1.0
        }
        rotate.toValue = toValue
        rotate.duration = TimeInterval(duration)
        rotate.repeatCount = repeatCount;
        icon.layer.add(rotate, forKey: nil)
    }
    
    fileprivate func playBounceAnimation(_ icon: UIImageView, _ repeatCount:Float) {
        let bounce = CAKeyframeAnimation(keyPath: NMAnimationKeys.Scale)
        bounce.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounce.duration = TimeInterval(duration)
        bounce.repeatCount = repeatCount;
        bounce.calculationMode = CAAnimationCalculationMode.cubic
        icon.layer.add(bounce, forKey: nil)
    }
    
    fileprivate func playFrameAnimation(_ icon: UIImageView, _ repeatCount:Float) {
        if self.animationImages.count == 0 {
            fatalError("images list is empty")
        }
        let frame = CAKeyframeAnimation(keyPath: NMAnimationKeys.KeyFrame)
        frame.calculationMode = CAAnimationCalculationMode.discrete
        frame.duration = TimeInterval(duration)
        frame.values = self.animationImages
        frame.repeatCount = repeatCount;
        frame.isRemovedOnCompletion = false
        frame.fillMode = CAMediaTimingFillMode.forwards
        icon.layer.add(frame, forKey: nil)
    }
    
}
