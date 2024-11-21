//
//  RankCardView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/22/24.
//

import SwiftUI

public struct RankCardView: View {
  
  public let rankData: RankEntity
  
  public var body: some View {
    VStack(spacing: 14) {
      topInfo()
      
      most3Champ()
    }
    .padding(.horizontal, GridRules.globalHorizontalPadding)
    .padding(.vertical, 10)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(.glBackground1)
        .stroke(.glGray3, lineWidth: 0.8)
    )
  }
}

private extension RankCardView {
  @ViewBuilder
  func topInfo() -> some View {
    HStack(spacing: 10) {
      VStack(alignment: .leading, spacing: 0) {
        Text(rankData.type.korName)
          .glFont(.body2Bold)
          .foregroundStyle(.glPrimary1)
          .padding(.vertical, 4)
          .padding(.horizontal, 8)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .fill(.glWinBlue)
          )
        
        HStack(spacing: 8) {
          Text("\(rankData.tier) \(rankData.rank)")
            .glFont(.body1Bold)
            .foregroundStyle(.white)
          
          Text("\(rankData.leaguePoints) LP")
            .glFont(.body2Bold)
            .foregroundStyle(.glGray1)
        }
        .padding(.top, 8)
        
        Text("\(rankData.wins)승 \(rankData.losses)패 (\(Int(rankData.winRate*100))%)")
          .glFont(.body2)
          .foregroundStyle(.glGray2)
          .padding(.top, 4)
      }
      
      Spacer()
      
      Image(uiImage: rankData.tier.tierImage)
        .resizable()
        .scaledToFit()
        .frame(width: 90, height: 90)
    }
  }
  
  @ViewBuilder
  func most3Champ() -> some View {
    HStack(spacing: 20) {
      ForEach(rankData.best3champions, id:\.self) { champion in
        VStack(spacing: 10) {
          CachedImageView(url: URL(string: champion.championImageUrl))
            .clipShape(Circle())
            .scaledToFit()
            .frame(maxWidth: .infinity)
          
          Text("\(String(format: "%.1f", champion.kills)) / \(String(format: "%.1f", champion.deaths)) / \(String(format: "%.1f", champion.assists))")
            .glFont(.navi).bold()
            .foregroundStyle(.glGray1)
        }
      }
    }
  }
}

#Preview {
  RankCardView(rankData: RankEntity(
    type: .soloRank,
    tier: .bronze,
    rank: "III",
    leaguePoints: 40,
    wins: 7,
    losses: 4,
    winRate: 0.6363636363636364,
    kda: 2.9615384615384617,
    avgKills: 12.909090909090908,
    avgDeaths: 7.090909090909091,
    avgAssists: 8.090909090909092,
    avgCs: 208,
    best3champions: [
      ChampionDTO(
        championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Jhin_0.jpg",
        kills: 14.8,
        deaths: 5.0,
        assists: 7.4,
        winRate: 0.8,
        wins: 4,
        losses: 1
      ),
      ChampionDTO(
        championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Aphelios_0.jpg",
        kills: 9.0,
        deaths: 8.0,
        assists: 8.0,
        winRate: 1.0,
        wins: 1,
        losses: 0
      ),
      ChampionDTO(
        championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Varus_0.jpg",
        kills: 15.0,
        deaths: 7.0,
        assists: 6.0,
        winRate: 1.0,
        wins: 1,
        losses: 0
      )
    ],
    veteran: false,
    inactive: false,
    freshBlood: false,
    hotStreak: false
  ))
}
