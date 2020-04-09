inhibit_all_warnings!

def app
  pod 'Kingfisher'
  pod 'SwinjectStoryboard'
end

def di_and_lint
  pod 'Swinject', '2.6.2'
  pod 'SwiftLint'
end

def tests
  pod 'Quick'
  pod 'Nimble'
end

target 'App-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  app
  di_and_lint

  target 'AppTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'App-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  app
  di_and_lint

  target 'AppTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Core-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  di_and_lint

  target 'CoreTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Core-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  di_and_lint

  target 'CoreTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Domain-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  di_and_lint

  target 'DomainTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Domain-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  di_and_lint

  target 'DomainTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Data-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  di_and_lint

  target 'DataTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Data-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  di_and_lint

  target 'DataTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Net-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'Alamofire'

  di_and_lint

  target 'NetTests-iOS' do
    use_frameworks!

    tests
  end
end

target 'Net-tvOS' do
  platform :tvos, '13.0'
  use_frameworks!

  pod 'Alamofire'

  di_and_lint

  target 'NetTests-tvOS' do
    use_frameworks!

    tests
  end
end

target 'Database-iOS' do
  platform :ios, '13.0'
  use_frameworks!

  pod 'CoreStore'

  di_and_lint

  target 'DatabaseTests-iOS' do
    use_frameworks!

    tests
  end
end
