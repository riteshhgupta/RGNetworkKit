Pod::Spec.new do |spec|
  spec.name         =  'RGNetworkKit'
  spec.version      =  '1.0'
  spec.summary   =  'Protocol oriented network layer on top of Alamofire with response & error handling ~ made in swift'
  spec.author = {
    'Ritesh Gupta' => 'rg.riteshh@gmail.com'
  }
  spec.license          =  'MIT' 
  spec.homepage         =  'https://github.com/riteshhgupta/RGNetworkKit'
  spec.source = {
    :git => 'https://github.com/riteshhgupta/RGNetworkKit.git',
    :tag => '1.0'
  }
  spec.ios.deployment_target = "10.0"
  spec.source_files =  'Source/*.{swift}'
  spec.requires_arc =  true
  spec.dependency 'Alamofire', '~> 4.3'
  spec.dependency 'RGMapper', :git => 'https://github.com/riteshhgupta/RGMapper.git'

end
