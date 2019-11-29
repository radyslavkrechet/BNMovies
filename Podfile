platform :ios, '12.0'
inhibit_all_warnings!

def swinject
  pod 'Swinject', '2.6.2'
end

def swift_lint
  pod 'SwiftLint'
end

def tests
  pod 'Quick'
  pod 'Nimble'
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

target 'DomainTests' do
  use_frameworks!

  swift_lint
  tests
end

target 'Data' do
  use_frameworks!

  swinject
  swift_lint
end

target 'DataTests' do
  use_frameworks!

  swift_lint
  tests
end

target 'Net' do
  use_frameworks!

  pod 'Alamofire'

  swinject
  swift_lint
end

target 'NetTests' do
  use_frameworks!

  swift_lint
  tests
end

target 'Database' do
  use_frameworks!

  pod 'CoreStore'

  swinject
  swift_lint
end
