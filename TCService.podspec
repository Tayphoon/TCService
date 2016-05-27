#
# Be sure to run `pod lib lint TCCollections.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TCService"
  s.version          = "0.1.0"
  s.summary          = "TCService is a set of classes for consuming and modeling RESTful web resources on iOS and OS X."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = "TCService is a set of classes for consuming and modeling RESTful web resources on iOS and OS X. It's make rest request and mapping response using RestKit."

  s.homepage         = "https://github.com/Tayphoon/TCService"
  s.license          = 'MIT'
  s.author           = { "Tayphoon" => "tayphoon.company@gmail.com" }
  s.source           = { :git => "https://github.com/Tayphoon/TCService.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

### Subspecs

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |cs|
    cs.public_header_files = 'TCService/Core/**/*.{h}'
    cs.source_files = 'TCService/Core/**/*.{h,m}'

    cs.dependency 'TCService/Utils'
    cs.dependency 'RestKit', '~> 0.26.0'
    cs.dependency 'RKValueTransformers'
    cs.prefix_header_contents = '#import <SystemConfiguration/SystemConfiguration.h>', '#import <MobileCoreServices/MobileCoreServices.h>'
    cs.frameworks = 'CFNetwork', 'Security', 'MobileCoreServices', 'SystemConfiguration', 'UIKit'
  end

  s.subspec 'Utils' do |us|
    us.public_header_files = 'TCService/Utils/**/*.{h}'
    us.source_files = 'TCService/Utils/**/*.{h,m}'
  end

end
