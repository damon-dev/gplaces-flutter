#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint gplaces.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'gplaces'
  s.version          = '0.0.1'
  s.summary          = "GPlaces provides programmatic access to Google's database of local place and business information, as well as the device's current place."
  s.description      = <<-DESC
  "GPlaces provides programmatic access to Google's database of local place and business information, as well as the device's current place."
                       DESC
  s.homepage         = 'https://github.com/19diwakar'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Diwakar Singh' => 'diwaka@factoryplus.in' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GooglePlaces', '7.1.0'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.static_framework = true
end
