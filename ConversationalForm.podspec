Pod::Spec.new do |s|
  s.name             = 'ConversationalForm'
  s.version          = '1.0.0'
  s.summary          = 'ConversationalForm - new way of the boring forms.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/marcinjackowski/ConversationalForm'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marcinjackowski' => 'mtc.jackowski@gmail.com' }
  s.source           = { :git => 'https://github.com/marcinjackowski/ConversationalForm.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mtc_jackowski'
  s.ios.deployment_target = '11.0'
  s.source_files = 'ConversationalForm/Classes/**/*'
  s.frameworks = 'UIKit', 'MapKit'
end
