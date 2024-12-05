//
//  ChattingFilterDetailView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/19/24.
//

import SwiftUI

public struct ChattingFilterDetailView: View {
  
  @ObservedObject private var viewModel: ChattingListViewModel
  
  init(viewModel: ChattingListViewModel) {
    self.viewModel = viewModel
  }
  
  @State var positionSelect: Set<LOLPosition> = []
  @State var gameTypeSelect: Set<LOLGameType> = []
  @State var tierSelect: Set<LOLTier> = []
  
  public var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 26) {
        section(filter: .position)
        section(filter: .gameType)
        section(filter: .tier)
      }
      .padding(.horizontal, GridRules.globalHorizontalPadding)
      .padding(.top, 20)
    }
    .background(.glBackground1)
    .glNavigation(
      centerContent: {
        Text("검색 필터")
          .glFont(.body1Bold)
          .foregroundStyle(.white)
      },
      leftContent: {
        Image(systemName: "chevron.left").bold()
          .foregroundStyle(.white)
          .padding(.horizontal, 6)
          .padding(.vertical, 4)
          .onTapGesture {
            viewModel.action(._moveBack)
          }
      }
    )
    .overlay(alignment: .bottom) {
      bottomSection()
    }
  }
}

private extension ChattingFilterDetailView {
  
  @ViewBuilder
  func section(filter: GameFilter) -> some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(filter.rawValue)
        .glFont(.body1Bold)
        .foregroundStyle(.white)
      
      switch filter {
      case .position:
        FlowRowLayoutView(horizontalSpacing: 8) {
          ForEach(LOLPosition.allCases, id:\.self) { position in
            capsule(title: position.korName, isSelected: positionSelect.contains(position))
              .onTapGesture {
                if positionSelect.contains(position) {
                  positionSelect.remove(position)
                } else {
                  positionSelect.insert(position)
                }
              }
          }
        }
        
      case .gameType:
        FlowRowLayoutView(horizontalSpacing: 8) {
          ForEach(LOLGameType.allCases, id:\.self) { gameType in
            capsule(title: gameType.korName, isSelected: gameTypeSelect.contains(gameType))
              .onTapGesture {
                if gameTypeSelect.contains(gameType) {
                  gameTypeSelect.remove(gameType)
                } else {
                  gameTypeSelect.insert(gameType)
                }
              }
          }
        }
        
      case .tier:
        FlowRowLayoutView(horizontalSpacing: 8) {
          ForEach(LOLTier.allCases, id:\.self) { tier in
            capsule(title: tier.korName, isSelected: tierSelect.contains(tier))
              .onTapGesture {
                if tierSelect.contains(tier) {
                  tierSelect.remove(tier)
                } else {
                  tierSelect.insert(tier)
                }
              }
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  @ViewBuilder
  func bottomSection() -> some View{
    HStack(spacing: 16) {
      Button {
        self.gameTypeSelect.removeAll()
        self.positionSelect.removeAll()
        self.tierSelect.removeAll()
      } label: {
        HStack(spacing: 4) {
          Image(systemName: "arrow.circlepath")
          
          Text("필터 초기화")
        }
        .glFont(.body2Bold)
        .foregroundStyle(.white)
      }
      
      GLButton(
        title: "\(self.gameTypeSelect.count + self.positionSelect.count + self.tierSelect.count)개 옵션 적용하기",
        isValid: true,
        action: { },
        activeColor: .primary3
      )
    }
    .padding(.horizontal, 20)
    .padding(.top, 20)
    .padding(.bottom, GridRules.globalBottomPadding)
    .background(.glBackground2)
  }
  
  @ViewBuilder
  func capsule(title: String, isSelected: Bool) -> some View {
    Text(title)
      .glFont(.body2Bold)
      .foregroundStyle(isSelected ? .glPrimary3 : .glGray1)
      .padding(.vertical, 9)
      .padding(.horizontal, 10)
      .background(
        Capsule()
          .fill(.clear)
          .strokeBorder(isSelected ? .glPrimary3 : .glGray1)
      )
  }
}


#Preview {
  ChattingFilterDetailView(
    viewModel: ChattingListViewModel(
      chatService: DefaultChatService(),
      coordinator: ChatCoordinator(initialScene: .filterList)
    )
  )
}
