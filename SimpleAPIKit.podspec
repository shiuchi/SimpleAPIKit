
Pod::Spec.new do |s|
  s.name         = "SimpleAPIKit"
  s.version      = "0.0.2"
  s.summary      = "SimpleAPIKit."
  s.description  =  "SimpleAPIKit for Swift"
  s.swift_version = '5.0'
  s.homepage     = "https://github.com/shiuchi/SimpleAPIKit"
  s.license      = "MIT"
  s.author             = { "shiuchi" => "s.shiuchi[at]gmail.com" }
  # s.platform     = :ios
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/shiuchi/SimpleAPIKit.git" , :tag => s.version.to_s}
  s.source_files  =  "SimpleAPIKit/Sources/**/*"
  s.requires_arc = true
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '(inherited)′,′LIBRARYSEARCHPATHS′=>′(inherited)', 'OTHER_LDFLAGS' => '$(inherited)' }
end