# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

inhibit_all_warnings!

def appPods
  pod 'IQKeyboardManagerSwift'
  pod 'GoogleSignIn'
  pod 'Kingfisher'
end

def apiPods
  pod 'SwiftyJSON'
  pod 'Result'
  pod 'Moya'
#  pod 'ReachabilitySwift'

end

target 'RedKite' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RedKite
  appPods
  apiPods

end

target 'RedKiteWebKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  apiPods
  # Pods for RedKiteWebKit

end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      #config.build_settings['SWIFT_VERSION'] = '2.3' # or '3.0'
    end
  end
end
