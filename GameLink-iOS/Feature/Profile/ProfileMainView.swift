//
//  ProfileMainView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/25/24.
//

import SwiftUI

struct ProfileMainView: View {
  
  @StateObject private var viewModel: ProfileViewModel = ProfileViewModel(service: DefaultRiotService())
  
  var body: some View {
    VStack {
      noAccountView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

private extension ProfileMainView {
  
  @ViewBuilder
  func noAccountView() -> some View {
    VStack(spacing: 10) {
      Text("현재 등록된 계정이 없어요 :(")
        .glFont(.title1)
        .foregroundStyle(.white)
      
      Text("계정을 등록하시면 인게임 정보를\n한 눈에 확인할 수 있어요!")
        .glFont(.body2)
        .foregroundStyle(.gray1)
    }
    .multilineTextAlignment(.center)
  }
}

#Preview {
  ProfileMainView()
}
