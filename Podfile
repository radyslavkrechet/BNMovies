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

target 'App-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'Kingfisher'

  pod 'SwinjectStoryboard'

  pod 'Firebase/Analytics'
  pod 'Fabric'
  pod 'Crashlytics'

  pod 'FLEX', :configurations => ['Debug (Development)']

  swinject
  swift_lint

  target 'AppTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'App-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  pod 'Kingfisher'

  pod 'SwinjectStoryboard'

  swinject
  swift_lint

  target 'AppTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Domain-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  swinject
  swift_lint

  target 'DomainTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Domain-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  swinject
  swift_lint

  target 'DomainTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Data-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  swinject
  swift_lint

  target 'DataTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Data-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  swinject
  swift_lint

  target 'DataTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Net-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'Alamofire'

  swinject
  swift_lint

  target 'NetTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Net-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  pod 'Alamofire'

  swinject
  swift_lint

  target 'NetTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Database-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'CoreStore'

  swinject
  swift_lint

  target 'DatabaseTests-iOS' do
    use_frameworks!

    tests
  end
end
