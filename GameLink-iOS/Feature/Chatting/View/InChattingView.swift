//
//  InChattingView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/26/24.
//

import SwiftUI

struct InChattingView: View {
  
  @State private var userInput: String = ""
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        Text("채팅방 내역")
      }
      
      userInputArea()
    }
    .task {
    
    }
    .glNavigation(
      centerContent: {
        Text("채팅방 이름")
          .glFont(.body1Bold)
          .foregroundStyle(.white)
      },
      leftContent: {
        Image(systemName: "chevron.left").bold()
          .foregroundStyle(.white)
          .padding(.horizontal, 6)
          .padding(.vertical, 4)
          .onTapGesture {
            
          }
      }
    )
  }
}

private extension InChattingView {
  
  @ViewBuilder
  func userInputArea() -> some View {
    HStack(spacing: 12) {
      TextField("", text: $userInput)
        .glFont(.body1)
        .foregroundStyle(.glGray1)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .background(
          Capsule()
          .fill(.glGray3)
        )
        .tint(.glPrimary1)
      
      Button {
        
      } label: {
        Image(systemName: "arrow.up")
          .foregroundStyle(.glBackground2)
          .padding(.vertical, 8)
          .padding(.horizontal, 12)
          .background(
            Circle()
              .fill(.primary1)
          )
      }
    }
    .background(
      .glBackground2
    )
    .padding(.horizontal, 16)
  }
}

#Preview {
  InChattingView()
}
