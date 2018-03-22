
# NMAnimatedTabBarItem

NMAnimatedTabBarItem is a Swift based UI module library for adding animation to iOS tabbar items and icons. iOS library made by [@Namshi Mobile Team](https://github.com/namshi).

![Demo](https://github.com/namshi/NMAnimatedTabBarItem/blob/master/Example/NMAnimatedTabBarItem/Images/NMAnimatedTabBarItem.gif)

## Requirements

- iOS 9.0+
- xCode 9
- Swift 3.2

## Installation

Just add the NMAnimatedTabBarItem folder to your project. or use [CocoaPods](https://cocoapods.org/pods/NMAnimatedTabBarItem) with Podfile:
``` ruby
pod 'NMAnimatedTabBarItem'
```

## Usage

1. Import NMAnimateTabBarItem framework.
```
import NMAnimatedTabBarItem
```
2. Create an instance of type NMAnimateTabBarItem.
```
var animatedTabBar = NMAnimateTabBarItem()
```

2. Adopt UITabBarControllerDelegate into your class.
```
class ViewController: UITabBarController , UITabBarControllerDelegate {
  //do Your stuff
}
```
3. Implement UITabBarControllerDelegate method.
```
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
       
       return true
    }
```

4. Find the index of selected tab and call animateTabBarItem.
```
 let indexOfTab = tabBarController.viewControllers?.index(of:viewController)
 animatedTabBar.animateTabBarItem(self.tabBar, indexOfTab!, NMAnimationtype.Bounce)
```
4. Make sure UITabBar item images are added.


## Included Animations
* Bounce
* Rotation
* Transition
* Frame

## Customized Properties
* Chenging animation duration.
```
animatedTabBar.duration = 0.2
```
* Providing transition Options.
```
animatedTabBar.transitionOptions = UIViewAnimationOptions.transitionFlipFromBottom
```
* Chenging rotation direction
```
animatedTabBar.direction = NMRotationDirection.right
```
* Passing image names for frame animation
```
            animationType = NMAnimationtype.Frame
            var imagesArray :[String] = []
            for index in 0...35 {
                imagesArray.append("frame_\(index)")
            }
            animatedTabBar.createImagesArray(imagesArray)
```
* Passing images for frame animation
```
            animationType = NMAnimationtype.Frame
            imagesList.append((UIImage(named: "image.png")?.cgImage)!)
            imagesList.append((UIImage(named: "image2.png")?.cgImage)!)
            imagesList.append((UIImage(named: "image3.png")?.cgImage)!)
            animatedTabBar.animationImages = imagesList
```

### Manual
You can download the latest files from our [Releases](https://github.com/namshi/NMAnimatedTabBarItem/releases) page. After doing so, copy the Swift file in the Sources folder to your project.

### Demo
Check out the Example project.

## Copyrights
This library has created by inspiration of [RAMAnimatedTabBarController](https://github.com/Ramotion/animated-tab-bar).

All right reserved. Namshi Team 2018.
