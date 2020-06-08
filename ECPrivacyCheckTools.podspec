#
# Be sure to run `pod lib lint ECPrivacyCheckTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ECPrivacyCheckTools'
  s.version          = '2.0.0'
  s.summary          = 'iOS 系统隐私权限检测工具。iOS system privacy permission check tools.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    iOS 系统隐私权限检测工具.
    支持 iOS 8.0+
    iOS system privacy permission check tools.
    Support iOS 8.0+
                      DESC
                      
  s.homepage         = 'https://github.com/EchoZuo/ECPrivacyCheckTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EchoZuo' => 'zuoqianheng@foxmail.com' }
  s.source           = { :git => 'https://github.com/EchoZuo/ECPrivacyCheckTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
#  s.module_name = 'ECPrivacyCheckTools'

  s.source_files = 'ECPrivacyCheckTools/Classes/*.{h,m}', 'ECPrivacyCheckTools/Classes/Core/*.{h,m}'
#  s.source_files = 'ECPrivacyCheckTools/Classes/**/*', 'ECPrivacyCheckTools/Classes/Core/*'
#   s.source_files = 'ECPrivacyCheckTools/Classes/**/*'
#   s.public_header_files = 'ECPrivacyCheckTools/Classes/**/*.h'
  
  # s.resource_bundles = {
  #   'ECPrivacyCheckTools' => ['ECPrivacyCheckTools/Assets/*.png']
  # }

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
