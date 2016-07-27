platform :ios, '8.0'
use_frameworks!

def common_pods
    # Since this library depends on 'prepare_command' for compiling SwiftGen
    # and other automations, we need to install it as a remote pod.
    pod 'Iconic', :git => 'https://github.com/dzenbot/Iconic.git', :submodules => true
end

target :YZGithub do
pod 'Alamofire'
pod 'IQKeyboardManagerSwift'
pod 'SwiftyJSON'
pod 'SnapKit'
pod 'Moya'
pod 'ObjectMapper'
pod 'Kingfisher'
pod 'ReachabilitySwift'
#pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift2'
pod 'MBProgressHUD'
pod 'DGElasticPullToRefresh'
pod "SwiftDate", "~> 2.0"
pod 'Bugly'
pod 'Static', git: 'https://github.com/flexih/Static.git'
pod "XMSegmentedControl"
common_pods
end
