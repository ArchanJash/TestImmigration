


Pod::Spec.new do |spec|

spec.name         = "Test"
spec.version      = "0.0.1"
spec.summary      = "Testing a podfile"
spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
DESC

spec.homepage     = "https://github.com/ArchanJash/Test.git"

spec.author             = { "Archan" => "archan@klizos.com" }

spec.dependency 'SVProgressHUD', '~> 1.1'
spec.dependency 'Alamofire'
spec.static_framework = true

spec.ios.deployment_target = "12.1"
spec.swift_version = "4.2"

spec.source       = { :git => "https://github.com/ArchanJash/Test.git", :tag => "#{spec.version}" }

spec.exclude_files = "Classes/Exclude"

end
