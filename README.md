# flagboard-ios
**The Feature Flag Dashboard**

Flagboard has a small and familiar API that allows you to use "local" remote configurations (AKA Feature Flags) inside your app.
It could be loaded from services like Firebase Remote Config or Apptimize. Custom feature flags can also be loaded on demand.
[![](https://jitpack.io/v/GrinGraz/flagboard-android.svg)](https://jitpack.io/#GrinGraz/flagboard-android)


## Usage
Add Flagboard to your project in the SPM Dependencies

```
https://github.com/GrinGraz/flagboard-ios.git //Up to Next Major Version 1.0.2 < 2.0.0
```

First, initialize Flagboard in your `AppDelegate` file
```swift
Flagboard.initialize()
```

Then, load your feature flags into Flagboard. There is a `ConflicStrategy` to keep or replace when feature flags are loaded
```swift
let mapOfFlags: [String:Any] = [:]
Flagboard.loadFlags(mapOfFlags, .keep)
```

Afterward, the feature flags can be retrieved in your app with functions by value type.

```swift
let isFeatureEnabled: Bool = Flagboard.getBoolean(stringKey)

if isFeatureEnabled {
    doSomethingGreat()
}
```

To display the Flagboards dashboard with the list of your loaded remote configuration call
```swift
Flagboard.open()
```

Then you will see this.

![image](https://github.com/GrinGraz/flagboard-android/assets/6061374/b12116f6-b714-493f-884e-492c19332476)

Here, you can change the value of your Boolean feature flags through a toggle button, and they will persist after restarting the app

Also, Flagboard can be reset anywhere
```swift
Flagboard.reset()
```

To retrieve the current status
```swift
Flagboard.getState()
```