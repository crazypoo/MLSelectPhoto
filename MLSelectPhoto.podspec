Pod::Spec.new do |s|
  s.name             = "MLSelectPhoto"
  s.version          = "0.4.0"
  s.summary          = "iOS that allows picking multiple photos and videos from user's photo library."
  s.homepage         = "https://github.com/MakeZL/MLSelectPhoto"
  s.license          = 'MIT'
  s.author           = { "zhangleo" => "zhangleowork@163.com" }
  s.source           = { :git => "https://github.com/MakeZL/MLSelectPhoto.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'MLSelectPhoto/Classes/**/*'
  s.resource     = "MLSelectPhoto/MLSelectPhoto.bundle"
end
