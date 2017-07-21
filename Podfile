platform :ios, '9.0'

plugin 'cocoapods-keys', {
  :project => 'Meow',
  :keys => [
    'LeanCloudAppId',
    'LeanCloudClientKey',
  ]
}
target 'Meow' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Meow
  pod 'Moya/RxSwift'
  pod 'ImageSlideshow'
  pod 'ImageSlideshow/Alamofire'
  pod 'SwiftyJSON'
  pod 'R.swift' 
  pod 'AVOSCloud'
  pod 'Qiniu'
  pod 'DateToolsSwift'
  pod 'PKHUD'
  pod 'AlamofireImage'
  pod 'TagListView'

  # 主模块(必须)
  pod 'ShareSDK3',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'
  # Mob 公共库(必须) 如果同时集成SMSSDK iOS2.0:可看此注意事项：http://bbs.mob.com/thread-20051-1-1.html
  pod 'MOBFoundation'

  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'ShareSDK3/ShareSDKUI',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'

 # ShareSDKPlatforms模块其他平台，按需添加
  # 如果需要的平台没有对应的平台语句，有2种情况——1、不需要添加这个平台的语句，如Twitter就是这个情况。2、ShareSDK暂时不支持此平台。
  pod 'ShareSDK3/ShareSDKPlatforms/QQ',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'
  pod 'ShareSDK3/ShareSDKPlatforms/WeChat',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'
  pod 'ShareSDK3/ShareSDKPlatforms/Mail',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'
  pod 'ShareSDK3/ShareSDKPlatforms/SMS',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'
  pod 'ShareSDK3/ShareSDKPlatforms/Copy',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'
  pod 'ShareSDK3/ShareSDKPlatforms/Evernote',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'

  # 扩展模块（在调用可以弹出我们UI分享方法的时候是必需的）
  pod 'ShareSDK3/ShareSDKExtension',:git => 'https://git.oschina.net/MobClub/ShareSDK-for-iOS-Spec.git'

  target 'MeowTests' do
    inherit! :search_paths
    # Pods for testing
  end


end
