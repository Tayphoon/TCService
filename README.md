# TCService

[![CI Status](http://img.shields.io/travis/Tayphoon/TCService.svg?style=flat)](https://travis-ci.org/Tayphoon/TCService)
[![Version](https://img.shields.io/cocoapods/v/TCService.svg?style=flat)](http://cocoapods.org/pods/TCService)
[![License](https://img.shields.io/cocoapods/l/TCService.svg?style=flat)](http://cocoapods.org/pods/TCService)
[![Platform](https://img.shields.io/cocoapods/p/TCService.svg?style=flat)](http://cocoapods.org/pods/TCService)

## Usage

To run the example project, clone the repo, and run `pod install` from the Demo directory first.

## Requirements

TCService requires [iOS 8.0](https://developer.apple.com/library/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS8.html) and above.

Several third-party open source libraries are used within TCService, including:

1. [RestKit](https://github.com/RestKit/RestKit) - Networking and Object mapping Support

The following Cocoa frameworks must be linked into the application target for proper compilation:

1. **CFNetwork.framework** on iOS
1. **CoreData.framework**
1. **Security.framework**
1. **MobileCoreServices.framework**

And the following linker flags must be set:

1. **-ObjC**
1. **-all_load**


## Installation

TCService is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TCService"
```

## Author

Tayphoon, tayphoon.company@gmail.com

## License

TCService is available under the MIT license. See the LICENSE file for more info.
