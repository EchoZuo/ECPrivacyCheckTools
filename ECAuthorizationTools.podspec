
Pod::Spec.new do |s|

  s.name         = "ECAuthorizationTools"
  s.version      = "1.0.0"
  s.summary      = "Checking and Requesting Access to Data Classes in Privacy Settings."
  s.homepage     = "https://github.com/EchoZuo/ECAuthorizationTools"
  s.license      = "MIT"
  s.author             = { "EchoZuo" => "zuoqianheng@foxmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/EchoZuo/ECAuthorizationTools.git", :tag => "1.0.0" }  
  s.requires_arc = true
  s.source_files = "ECAuthorizationTools/ECAuthorizationTools/ECAuthorizationTools/*.{h,m}"

end
