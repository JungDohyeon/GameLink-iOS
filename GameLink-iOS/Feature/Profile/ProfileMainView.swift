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
      Text("로그인 정보가 없습니다.")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

#Preview {
  ProfileMainView()
}
