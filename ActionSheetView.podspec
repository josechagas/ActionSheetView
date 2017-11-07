#
# Be sure to run `pod lib lint ActionSheetView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ActionSheetView'
  s.version          = '0.3.0'
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
  s.author           = { 'josechagas' => 'chagasjoselucas@nucleus.eti.br' }
  s.source           = { :git => 'https://github.com/josechagas/ActionSheetView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ActionSheetView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ActionSheetView' => ['ActionSheetView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
