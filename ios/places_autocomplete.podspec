#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint places_autocomplete.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'places_autocomplete'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin for handle google place api that place search and details and photos and autocomplete and query autocomplete requests are available'
  s.description      = <<-DESC
'A new Flutter plugin for handle google place api that place search and details and photos and autocomplete and query autocomplete requests are available'
                       DESC
  s.homepage         = 'https://github.com/19diwakar'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Diwakar Singh' => 'diwaka@factoryplus.in' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GooglePlaces'
  s.dependency 'GoogleMaps'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.static_framework = true
end
