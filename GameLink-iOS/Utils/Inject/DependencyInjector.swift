//
//  DependencyInjector.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/5/24.
//

import Swinject

public protocol DependencyAssemblable {
  func assemble(_ assemblyList: [Assembly])
  func register<T>(_ serviceType: T.Type, _ object: T)
}

public protocol DependencyResolvable {
  func resolve<T>(_ serviceType: T.Type) -> T
  func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T
}

public typealias Injector = DependencyAssemblable & DependencyResolvable

public final class DependencyInjector: Injector {
  private let container: Container
  
  public init(container: Container) {
    self.container = container
  }
  
  public func assemble(_ assemblyList: [Assembly]) {
    assemblyList.forEach {
      $0.assemble(container: container)
    }
  }
  
  public func register<T>(_ serviceType: T.Type, _ object: T) {
    container.register(serviceType) { _ in object }
  }
  
  public func resolve<T>(_ serviceType: T.Type) -> T {
    container.resolve(serviceType)!
  }
  
  public func resolve<T, Arg>(_ serviceType: T.Type, argument: Arg) -> T {
    container.resolve(serviceType, argument: argument)!
  }
}
