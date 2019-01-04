# ActionSheetView
[![Version](https://img.shields.io/cocoapods/v/ActionSheetView.svg?style=flat)](http://cocoapods.org/pods/ActionSheetView)
[![License](https://img.shields.io/cocoapods/l/ActionSheetView.svg?style=flat)](http://cocoapods.org/pods/ActionSheetView)
[![Platform](https://img.shields.io/cocoapods/p/ActionSheetView.svg?style=flat)](http://cocoapods.org/pods/ActionSheetView)

A Simple way to manage and use any ViewController as  actionsheets.
=======

Here are some screenshots showing some examples of what you can do with ActionSheetView:

![Example1 Screenshots](https://raw.githubusercontent.com/josechagas/ActionSheetView/master/ReadmeAssets/screens1.jpg)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 10.0+

## Installation

ActionSheetView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ActionSheetView'
```

### Step 1: Creating my ActionSheetViewController
Choose any ViewController you created and implement the protocol 'ActionSheetView':

```swift
class MyActionSheetVC: UIViewController,ActionSheetView
```

### Step 2: Creating my ActionSheetManager
Create a class that inherit from 'ASManagerVC':

```swift
class MyASManagerVC: ASManagerVC
```

IMPORTANT: If your 'MyASManagerVC' overrides the method 'viewWillAppear' you have to call 'super.viewWillAppear'.

### Step 3: Defining my Delegate
Choose some class and implement the protocol 'ActionSheetViewDelegate'

```swift
class MyDelegate: ActionSheetViewDelegate
```

#### Step 3.1: Informing to your 'ASManagerVC'
Get the instance of your 'ActionSheetViewDelegate' and inform to your 'ASManagerVC':

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = MyDelegate()
}
```


### Step 4: Connect everything on storyboard and interface builder
Create a custom segue from your 'MyASManagerVC' to 'MyActionSheetVC' of class 'ASViewSegue'
Choose an identifier and inform it to your 'MyASManagerVC', you can do it on interface builder.


### Protocols
Below you can see all protocols actually available, take a look on methods, each method and parameter has its own doc on project.

```swift
public protocol ActionSheetViewDelegate{
    func bottomVC(_ vc:UIViewController)
    func initialSize()->CGSize
    func finalSize()->CGSize
    func showDarkBackgroundLayer()->Bool
    func darkLayerOpacityForState(_ state:ActionSheetViewState)->Float
}

public protocol ActionSheetView:class {
    var controller:ActionSheetViewManager?{get set}
    func didChangeToState(_ state:ActionSheetViewState)
    func apperanceChangesFor(NewState state:ActionSheetViewState)
    func constraintChangesFor(NewState state:ActionSheetViewState)
    func uiChangesFor(Progress quant:CGFloat, BigStateProgress big:CGFloat, SmallStateProgress small:CGFloat)
}

public protocol ActionSheetViewManager{
    func changeToState(_ state:ActionSheetViewState,Animated animated:Bool)
    func reloadActionSheetView()
}
```

### Looking for more details?
Take a look on Example project and methods documentation.


### Doubts?
Create some issue and we can solve it together.


## Author

josechagas

## License

ActionSheetView is available under the MIT license. See the LICENSE file for more info.

