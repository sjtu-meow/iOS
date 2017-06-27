platform :ios, '9.0'

plugin 'cocoapods-keys', {
  :project => 'Meow',
  :keys => [
    'LeanCloudAppId',
    'LeanCloudClientKey'
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
  pod 'QCloudCOSV4'
  pod 'DateToolsSwift'

  target 'MeowTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MeowUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
