platform :ios, "9.0"
use_frameworks!

#sources
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/worldline-spain/t21_pods-specs_ios.git'

#IMPORTANT: Change the name of the workspace according to your workspace for the project.
workspace 'MyApp'
project 'MyApp'


target 'MyApp' do
    
    pod 'Alamofire'
    pod 'Moya'
    pod 'SwifterSwift'
    pod 'Kingfisher'
    pod 'RNCryptor', '~> 5.0'
    pod 'MBProgressHUD'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
    pod 'Swinject'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'SwiftLint'
    pod 'Marshal'
    
    pod 'T21MaterialTextField'
    pod 'T21KeyboardState'
    pod 'T21Button'
    pod 'T21RealmStoreSwift'
    pod 'T21TableViewDataSource'
    pod 'T21LoggerSwift'
    pod 'T21EnvironmentSwift'
    pod 'T21Mapping'
    pod 'T21HTTPRequester'
    pod 'T21PullToRefreshController', '2.0.0'
    pod 'T21RxAdditions'
    
    target 'MyAppTests' do
    
    end
    
    target 'MyAppUITests' do
        
    end
end



post_install do |installer|
    installer.pods_project.targets.each do |target|
        
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
            if config.name == 'devel' || config.name == 'Debug' || config.name == 'uat_debug' || config.name == 'pro_debug'
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEBUG=1']
                config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['$(inherited)','-DDEBUG']
                config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
            end
        end
    end
end
