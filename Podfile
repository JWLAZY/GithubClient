platform :ios, '10.0'
use_frameworks!

def common_pods
    #pod 'Iconic', :git => 'https://github.com/dzenbot/Iconic.git', :submodules => true
end

target :YZGithub do
    pod 'Alamofire','~> 4.0'
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'IQKeyboardManagerSwift'
    pod 'SwiftyJSON'
    pod 'SnapKit'
    pod 'Moya', '8.0.0-beta.4'
    pod 'ObjectMapper'
    pod 'Kingfisher'
    pod 'ReachabilitySwift'
    pod 'MBProgressHUD'
    pod 'DGElasticPullToRefresh'
    pod "SwiftDate"
    pod 'Bugly'
    pod 'Static', git: 'https://github.com/flexih/Static.git'
    pod 'AttributedMarkdown', :git => 'https://github.com/dreamwieber/AttributedMarkdown.git'
    pod "WeiboSDK", :git => "https://github.com/sinaweibosdk/weibo_ios_sdk.git"
    common_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
