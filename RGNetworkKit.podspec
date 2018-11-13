Pod::Spec.new do |spec|
  spec.name         =  'RGNetworkKit'
  spec.version      =  '1.0'
  spec.summary      =  'Protocol oriented network layer on top of Alamofire with response & error handling ~ made in swift'
  spec.author       =  { 'Ritesh Gupta' => 'rg.riteshh@gmail.com' }
  spec.license      =  'MIT' 
  spec.homepage     =  'https://github.com/riteshhgupta/RGNetworkKit'
  spec.requires_arc =  true
  spec.ios.deployment_target = "9.0"
  
  spec.source = {
    :git => 'https://github.com/riteshhgupta/RGNetworkKit.git',
    :tag => '1.0'
  }
  
  spec.subspec 'Core' do |core|
    core.dependency 'Alamofire', '~> 4.7'
    core.dependency 'RGMapper', '~> 2.1'
    core.source_files =  'Source/**/*.swift', 'Source/**/*.xib'
    core.exclude_files = 'Source/Reactive/*.swift'
  end

  spec.subspec 'ReactiveSwift' do |reactiveswift|    
    reactiveswift.dependency 'RGNetworkKit/Core'
    reactiveswift.dependency 'ReactiveSwift', '~> 4.0'
    reactiveswift.dependency 'ReactiveCocoa', '~> 8.0'
    reactiveswift.source_files =  'Source/**/*.swift'
  end

  spec.default_subspec = 'Core'
end
