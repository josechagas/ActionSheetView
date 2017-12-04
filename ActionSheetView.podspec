#
# Be sure to run `pod lib lint ActionSheetView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

#[![CI Status](http://img.shields.io/travis/josechagas/ActionSheetView.svg?style=flat)](https://travis-ci.org/josechagas/ActionSheetView)

Pod::Spec.new do |s|
  s.name             = 'ActionSheetView'
  s.version          = '1.0.1'
  s.summary          = 'ActionSheetView they are cool and now you have the possibility to create customized ones.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
What do you think about Maps and Uber ActionSheetViews ?! They are good and powerfull because you can add a lot of information with no worries about affecting user experience.
ActionSheetView is a library that brings the possiblity to turn any ViewController into a style of an ActionSheetView with some small configurations.
DESC

  s.homepage         = 'https://github.com/josechagas/ActionSheetView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'josechagas' => 'chagasjoselucas@gmail.com' }
  s.source           = { :git => 'https://github.com/josechagas/ActionSheetView.git', :tag => s.version.to_s }
#s.source           = { :git => 'https://github.com/josechagas/ActionSheetView.git', :commit => "0e0e43fd2cf6290a36e21dcf1c7182da90a41182" }


  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Classes/**/*'
  
  # s.resource_bundles = {
  #   'ActionSheetView' => ['ActionSheetView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
