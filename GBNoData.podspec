
Pod::Spec.new do |s|
  s.name             = 'GBNoData'
  s.version          = '1.0.0'
  s.summary          = 'A short description of GBNoData.'
  s.homepage         = 'https://github.com/Lucas-iOS/GBNoData'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucas' => 'gaobo_it@163.com' }
  s.source           = { :git => 'git@github.com:Lucas-iOS/GBNoData.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'GBNoData/Classes/**/*'

  # s.resource_bundles = {
  #   'GBNoData' => ['GBNoData/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
