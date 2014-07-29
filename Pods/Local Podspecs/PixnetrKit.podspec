Pod::Spec.new do |spec|
  spec.name	= 'PixnetrKit'
	spec.summary = 'A library for internet access for Pixnetr app'
	spec.version = '1.0'
	spec.license = {:type => 'MIT', :file => 'LICENSE'}
	spec.authors = {'Vincent Chen' => 'vincent@vincenttt.com'}
	
	spec.platform = :ios, '7.0'
	spec.source_files = 'PixnetrKit'
	spec.requires_arc = true

  spec.dependency 'PIXNET-iOS-SDK'
	spec.dependency 'Parse-iOS-SDK'
end
