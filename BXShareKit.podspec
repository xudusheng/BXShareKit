#
# Be sure to run `pod lib lint BXShareKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BXShareKit'
  s.version          = '0.0.1'
  s.summary          = '分享模块'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
碧选分享组件
                       DESC

  s.homepage         = 'https://github.com/xudusheng/BXShareKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xudusheng' => 'xudusheng@bisinuolan.com' }
  s.source           = { :git => 'https://github.com/xudusheng/BXShareKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BXShareKit/Classes/**/*'
  
   s.resource_bundles = {
     'BXShareKit' => ['BXShareKit/Assets/*.png']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
 # s.dependency 'AFNetworking', '~> 2.3'

 #解决报错：[-Werror,-Wnon-modular-include-in-framework-module]
 s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
 #解决报错 The 'Pods-App' target has transitive dependencies that include static binaries
 s.static_framework = true

# 友盟分享
s.dependency 'UMCCommon', '2.0.1'
s.dependency 'UMCSecurityPlugins', '1.0.6'
#UI模块（分享面板，建议添加）
s.dependency 'UMCShare/UI', '6.9.5'
#    # 集成微信(完整版14.4M)
#    pod 'UMCShare/Social/WeChat'
#    # 集成QQ/QZone/TIM(完整版7.6M)
#    pod 'UMCShare/Social/QQ'
#    # 集成新浪微博(完整版25.3M)
#    pod 'UMCShare/Social/Sina'

# 集成微信(精简版0.2M)
s.dependency 'UMCShare/Social/ReducedWeChat', '6.9.5'
# 集成QQ/QZone/TIM(精简版0.5M)
s.dependency 'UMCShare/Social/ReducedQQ', '6.9.5'
# 集成新浪微博(精简版1M)
s.dependency 'UMCShare/Social/ReducedSina', '6.9.5'
end
