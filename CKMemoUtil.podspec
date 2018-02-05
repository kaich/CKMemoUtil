#
# Be sure to run `pod lib lint CKMemoUtil.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CKMemoUtil'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CKMemoUtil.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chengkai1853@163.com/CKMemoUtil'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chengkai1853@163.com' => 'chengkai1853@163.com' }
  s.source           = { :git => 'https://github.com/chengkai1853@163.com/CKMemoUtil.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CKMemoUtil/Classes/**/*'
  s.vendored_frameworks = 'CKMemoUtil/Lib/iflyMSC.framework'
  s.vendored_libraries = 'CKMemoUtil/Lib/libopencore-amrnb.a', 'CKMemoUtil/Lib/libopencore-amrwb.a'
  
  # s.resource_bundles = {
  #   'CKMemoUtil' => ['CKMemoUtil/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'AVFoundation', 'SystemConfiguration', 'CoreTelephony', 'AudioToolbox', 'CoreLocation', 'Contacts', 'AddressBook', 'QuartzCore'
  s.libraries = 'z', 'c++'
  # s.dependency 'AFNetworking', '~> 2.3'
end
