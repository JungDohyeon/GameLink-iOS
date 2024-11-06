//
//  AuthView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import SwiftUI

public struct AuthView: View {
  
  @EnvironmentObject private var viewModel: AuthViewModel
  
  public var body: some View {
    VStack {
      Text("GameLink")
        .foregroundStyle(.primary2)
        .glFont(.head1)
        .padding(.top, 150)
      
      Spacer()
      
      Button(action: {
        viewModel.action(.tappedLogin(.kakao))
      }, label: {
        Text("KakaoLogin")
      })
      .padding(.bottom, 100)
    }
    .frame(maxWidth: .infinity)
    .background(.background1)
  }
}

#Preview {
  AuthView()
    .environmentObject(AuthViewModel(service: DefaultUserService()))
}
