# flagboard-ios
**The Feature Flag Dashboard**

Flagboard has a small and familiar API that allows you to use "local" remote configurations (AKA Feature Flags) inside your app.
It could be loaded from services like Firebase Remote Config or Apptimize. Custom feature flags can also be loaded on demand.

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
When the `.keep` strategy is on, the state of the feature flags will persist after restarting the app. If the `.replace` strategy is selected, the feature flags persist in memory during the app session; this is the correct strategy to sync the feature flags with your remote.

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

<img width="514" alt="image" src="https://github.com/GrinGraz/flagboard-ios/assets/6061374/32078b7f-3f4e-40b7-914c-4d884d6fb1ec">


Here, you can change the value of your Boolean feature flags through a toggle button.

Also, Flagboard can be reset anywhere
```swift
Flagboard.reset()
```

To retrieve the current status
```swift
Flagboard.getState()
```
