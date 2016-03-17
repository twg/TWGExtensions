Pod::Spec.new do |s|
  s.name             = "TWGExtensions"
  s.version          = "0.2.5"
  s.summary          = "A collection of useful categories."
  s.description      = <<-DESC
                       TWG developed categories and extensions on foundation. Useful for resulable code
                       DESC
  s.homepage         = "https://github.com/twg"
  s.license          = 'MIT'
  s.author           = { "The Working Group" => "mobile@twg.ca" }
  s.source           = { :git => "https://github.com/twg/TWGExtensions.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
