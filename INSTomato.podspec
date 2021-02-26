#
# Be sure to run `pod lib lint INSTomato.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'INSTomato'
  s.version          = '0.0.14'
  s.summary          = '番茄时钟'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
番茄时钟的具体说明：
                     DESC

  s.homepage         = 'https://github.com/Inspirelife96/INSTomato'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'inspirelife@hotmail.com' => 'inspirelife@hotmail.com' }
  s.source           = { :git => 'https://github.com/Inspirelife96/INSTomato.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'INSTomato/Classes/**/*'
  
  s.swift_version = '4.0'
  
  s.resource_bundles = {
     'INSTomato' => ['INSTomato/Assets/*.*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation'
  s.dependency 'ChameleonFramework'
  s.dependency 'Masonry'
  s.dependency 'Charts'
  s.dependency 'PulsingHalo'
  s.dependency 'SVProgressHUD'
  s.dependency 'AFNetworking', '~> 4.0'
  s.dependency 'SCLAlertView-Objective-C'
end
