platform :ios, '12.0'
inhibit_all_warnings!

def swinject
  pod 'Swinject', '2.6.2'
end

def swift_lint
  pod 'SwiftLint'
end

target 'Boilerplate' do
  use_frameworks!

  pod 'Kingfisher'

  pod 'SwinjectStoryboard'

  pod 'Firebase/Analytics'
  pod 'Fabric'
  pod 'Crashlytics'

  pod 'FLEX'

  swinject
  swift_lint
end

target 'Domain' do
  use_frameworks!

  swinject
  swift_lint
end

target 'Data' do
  use_frameworks!

  swinject
  swift_lint
end

target 'Net' do
  use_frameworks!

  pod 'Alamofire'

  swinject
  swift_lint
end

target 'Database' do
  use_frameworks!

  pod 'CoreStore'

  swinject
  swift_lint
end
