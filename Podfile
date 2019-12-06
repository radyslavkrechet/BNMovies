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

  target 'DomainTests' do
    use_frameworks!

    tests
  end
end

target 'Data' do
  use_frameworks!

  swinject
  swift_lint

  target 'DataTests' do
    use_frameworks!

    tests
  end
end

target 'Net' do
  use_frameworks!

  pod 'Alamofire'

  swinject
  swift_lint

  target 'NetTests' do
    use_frameworks!

    tests
  end
end

target 'Database' do
  use_frameworks!

  pod 'CoreStore'

  swinject
  swift_lint

  target 'DatabaseTests' do
    use_frameworks!

    tests
  end
end
