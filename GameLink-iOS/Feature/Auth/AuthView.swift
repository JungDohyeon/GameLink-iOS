//
//  AuthView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import SwiftUI

public struct AuthView: View {
  
  @StateObject private var viewModel: AuthViewModel = AuthViewModel()
  
  public var body: some View {
    VStack {
      Button(action: {
        viewModel.action(.tappedLogin(.kakao))
      }, label: {
        Text("KakaoLogin")
      })
    }
    .padding()
  }
}

#Preview {
  AuthView()
}
