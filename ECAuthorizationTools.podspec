
Pod::Spec.new do |s|

  s.name         = "ECAuthorizationTools"
  s.version      = "1.0.0"
  s.summary      = "A short description of ECAuthorizationTools."
  s.homepage     = "https://github.com/EchoZuo/ECAuthorizationTools"
  s.license      = "MIT"
  s.author             = { "EchoZuo" => "zuoqianheng@foxmail.com" }
  s.social_media_url   = "http://twitter.com/ZuoEcho"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/EchoZuo/ECAuthorizationTools.git", :tag => "1.0.0" }  
  s.requires_arc = true
  s.source_files = "ECAuthorizationTools/ECAuthorizationTools/*.{h,m}"

end
