//
//  ProfileMainView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/25/24.
//

import SwiftUI

struct ProfileMainView: View {
  
  @EnvironmentObject private var viewModel: ProfileViewModel
  
  @FocusState private var focusState: GLTextFieldType?
  
  var body: some View {
    contents()
      .task {
        viewModel.action(.mainViewAppear)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.glBackground1, ignoresSafeAreaEdges: .all)
  }
}

private extension ProfileMainView {
  
  @ViewBuilder
  func contents() -> some View {
    if let userData = viewModel.userProfileInfo {
      UserProfileView(userData: userData)
    } else {
      VStack(spacing: 0) {
        noAccountView()
        
        Spacer()
      }
    }
  }
  
  @ViewBuilder
  func noAccountView() -> some View {
    VStack(spacing: 0) {
      VStack(spacing: 10) {
        Text("현재 등록된 계정이 없어요 :(")
          .glFont(.title1)
          .foregroundStyle(.white)
        
        Text("계정을 등록하시면 인게임 정보를\n한 눈에 확인할 수 있어요!")
          .glFont(.body2)
          .foregroundStyle(.glGray1)
      }
      .multilineTextAlignment(.center)
      .padding(.bottom, 42)
      
      VStack(spacing: 10) {
        GLTextField(
          type: .nickname,
          focusState: $focusState,
          inputText: Binding(
            get: { viewModel.nickname },
            set: { text in
              viewModel.action(._setNickname(text))
            }
          )
        )
        
        GLTextField(
          type: .gametag,
          focusState: $focusState,
          inputText: Binding(
            get: { viewModel.tag },
            set: { text in
              viewModel.action(._setTag(text))
            }
          )
        )
      }
      .padding(.bottom, 30)
      
      GLButton(
        title: "등록",
        isValid: !viewModel.nickname.isEmpty && !viewModel.tag.isEmpty,
        action: { viewModel.action(.tappedRegistButton) },
        activeColor: .glPrimary3
      )
    }
    .padding(.horizontal, GridRules.globalHorizontalPadding)
    .padding(.top, 150)
  }
}

#Preview {
  ProfileMainView()
    .environmentObject(ProfileViewModel(service: DefaultRiotService()))
}
