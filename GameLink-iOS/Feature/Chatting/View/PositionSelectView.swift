//
//  PositionSelectView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import SwiftUI

struct PositionSelectView: View {
  
  @State private(set) var selectedPosition: LOLPosition = .top

  let enterAction: (LOLPosition) -> Void
  
  init(enterAction: @escaping (LOLPosition) -> Void) {
    self.enterAction = enterAction
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text("포지션 선택")
        .glFont(.title1)
        .foregroundStyle(.white)
        .padding(.top, 30)
      
      HStack(spacing: 8) {
        ForEach(LOLPosition.allCases, id: \.self) { tier in
          if let positionImage = tier.positionImage {
            Image(uiImage: positionImage)
              .resizable()
              .frame(maxWidth: .infinity)
              .scaledToFit()
              .padding(6)
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .stroke(selectedPosition == tier ? .glPrimary3 : .clear, lineWidth: 1.4)
              )
              .onTapGesture {
                selectedPosition = tier
              }
          }
        }
      }
      .padding(.top, 30)
      
      Button {
        selectedPosition = .any
      } label: {
        Text(LOLPosition.any.korName)
          .glFont(.title2)
          .foregroundStyle(selectedPosition == .any ? .glPrimary2 : .glGray2)
          .padding(.vertical, 8)
          .padding(.horizontal, 10)
          .background(
            Capsule()
              .stroke(selectedPosition == .any ? .glPrimary3 : .clear, lineWidth: 2)
          )
      }
      .padding(.top, 16)
      
      GLButton(
        title: "선택하기",
        isValid: true,
        action: { enterAction(self.selectedPosition) },
        activeColor: .glPrimary3
      )
      .padding(.top, 40)
      .padding(.bottom, 20)
    }
    .padding(.horizontal, GridRules.globalHorizontalPadding)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(.glBackground1)
    )
  }
}

#Preview {
  PositionSelectView(enterAction: { _ in })
    .padding(.horizontal, GridRules.globalHorizontalPadding)
}
