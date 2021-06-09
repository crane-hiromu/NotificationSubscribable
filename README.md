# NotificationSubscribable

## Description

Do you get a mess of similar code with only different notification names?

```swift
func observe() {
    NotificationCenter
            .Publisher(center: .default, name: Notification.Name("Name_A"), object: nil)
            .sink { [weak self] notification in
                // do something when receive `Name_A`
            }
            .store(in: &cancellables)

    NotificationCenter
            .Publisher(center: .default, name: Notification.Name("Name_B"), object: nil)
            .sink { [weak self] notification in
                // do something when receive `Name_B`
            }
            .store(in: &cancellables)

    NotificationCenter
            .Publisher(center: .default, name: Notification.Name("Name_C"), object: nil)
            .sink { [weak self] notification in
                // do something when receive `Name_C`
            }
            .store(in: &cancellables)
}
```

You can use ``Combine`` to standardize the code and have a clean implementation.

```swift
func observe() {
    [Notification.Name("Name_A"),
     Notification.Name("Name_B"),
     Notification.Name("Name_C")]
        .map { NotificationCenter.Publisher(center: .default, name: $0) }
        .publisher
        .flatMap { $0 }
        .sink(receiveValue: { [weak self] notification in
            // do something
        })
        .store(in: &cancellable)
}
```

We make the code has been cloaked and made into a library of ``NotificationSubscribable``.

### Example


```swift
final class ViewController: UIViewController, NotificationSubscribable {

    override func loadView() {
        super.loadView()

        startObserveNotificationCenter(notifications: [
            Notification.Name("Name_A"),
            Notification.Name("Name_B"),
            Notification.Name("Name_C")
        ]) { [weak self] notification in
            // do something
        }
    }
}
```


## Installing

### CocoaPods

Add the following line to your Podfile:

```
pod 'NotificationSubscribable', :git => 'git@github.com:crane-hiromu/NotificationSubscribable.git', :branch => 'main'
```

### Carthage

Add the following to your Cartfile:

```
github "crane-hiromu/NotificationSubscribable"
```

#### Supplement

If you fail to install, reset caches. (``rm -rf ~/Library/Caches/``)



### Swift Package Manager

Add the following dependency to your Package.swift file:

```
.package(url: "https://github.com/crane-hiromu/NotificationSubscribable.git", from: "1.0.0")
```

### License

MIT, of course ;-) See the LICENSE file.




