Pod::Spec.new do |s|
  s.name         = "FourChanAPI"
  s.module_name  = "FourChanAPI"
  s.version      = "0.0.1"
  s.summary      = "Wrapper for the 4chan api"
  s.description  = <<-DESC
                    Wrapper for the 4chan API. For iOS/OS X
                   DESC
  s.homepage     = "https://github.com/nuclearace/FourChanAPI"
  s.license      = { :type => 'MIT' }
  s.author       = { "Erik" => "nuclear.ace@gmail.com" }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/nuclearace/FourChanAPI.git", :tag => 'v0.0.1' }
  s.source_files  = "Source/**/*.swift"
  s.requires_arc = true
  # s.dependency 'Starscream', '~> 0.9' # currently this repo includes Starscream swift files
end
