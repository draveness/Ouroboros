#
# Be sure to run `pod lib lint Ouroboros.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Ouroboros"
  s.version          = "0.3.0"
  s.summary          = "The ObjectiveC library for magical scroll interactions."

  s.description      = <<-DESC
                       Ouroboros is inspired by ScrollMagic which helps you to easily react to the user's current
                       scroll position. With Ouroboros, you can easily create introduction pages.
                       DESC

  s.homepage         = "https://github.com/Draveness/Ouroboros"
  s.license          = 'MIT'
  s.author           = { "Draveness" => "stark.draven@gmail.com" }
  s.source           = { :git => "https://github.com/Draveness/Ouroboros.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Ouroboros' => ['Pod/Assets/*.png']
  }
end
