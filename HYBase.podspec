#
#  Be sure to run `pod spec lint HYBase.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "HYBase"
  spec.version      = "1.0.0"
  spec.summary      = "基础类，包含基于AFNetworking的网络请求、HUB、Toast、ActionSheet等"
  spec.description  = <<-DESC
                          基础类，包含基于AFNetworking的网络请求、HUB、Toast、ActionSheet等"
                      DESC
  spec.homepage     = "https://github.com/dolacmeng/HYBaseDemo"
  spec.license      = "MIT"
  spec.author             = { "jackxu" => "151611438@qq.com" }
  spec.source       = { :git => "https://github.com/dolacmeng/HYBaseDemo.git", :tag => "1.0.0" }
  spec.source_files  = "HYBase/HYBaseFile"
  spec.frameworks  = "UIKit","Foundation"
  spec.requires_arc = true
  spec.ios.dependency 'AFNetworking'
  spec.ios.dependency 'MBProgressHUD'
  spec.ios.dependency 'YYKit'
  spec.ios.dependency 'MWPhotoBrowser'
  spec.ios.dependency 'MJRefresh'
  spec.ios.dependency 'IQKeyboardManager'

end
