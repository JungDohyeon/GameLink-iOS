//
//  UserDefaultsWrapper.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
  private let key: String
  
  init(key: String) {
    self.key = key
  }
  
  var wrappedValue: T? {
    get {
      UserDefaults.standard.object(forKey: key) as? T
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: key)
    }
  }
}
