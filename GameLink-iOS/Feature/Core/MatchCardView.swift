//
//  MatchCardView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/22/24.
//

import SwiftUI

public struct MatchCardView: View {
  
  let matchData: LOLMatchEntity
  
  public init(matchData: LOLMatchEntity) {
    self.matchData = matchData
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      Rectangle()
        .fill(matchData.win ? .blue : .errorRed)
        .frame(width: 8)
        .padding(.trailing, 10)
      
      VStack(alignment: .leading, spacing: 0) {
        Text(matchData.matchType.korName)
          .glFont(.body2Bold)
          .foregroundStyle(matchData.win ? .blue : .errorRed)
          .padding(.bottom, 2)
        
        Text(matchData.win ? "승리" : "패배")
          .glFont(.body2)
          .foregroundStyle(.glGray2)
        
        Spacer()
      }
      .padding(.vertical, 10)
      
      Spacer()
      
      if let positionImage = matchData.teamPosition.positionImage {
        Image(uiImage: positionImage)
          .resizable()
          .frame(width: 50, height: 50)
      }
    }
    .padding(.trailing, 14)
    .frame(height: 100)
    .background(
      matchData.win ? .winBlue : .glLooseRed
    )
    .clipShape(.rect(cornerRadius: 8))
  }
}

#Preview {
  VStack {
    MatchCardView(
      matchData: LOLMatchEntity(
        matchId: "string",
        matchType: .freeRank,
        championName: "아트록스",
        doubleKills: 1,
        firstBloodKill: true,
        teamPosition: .mid,
        pentaKills: 0,
        assists: 5,
        deaths: 3,
        kills: 5,
        kda: 3.3,
        firstBloodAssist: true,
        firstTowerAssist: true,
        firstTowerKill: true,
        goldPerMinute: 300,
        gameEndedInEarlySurrender: true,
        gameEndedInSurrender: true,
        timePlayed: 0,
        totalMinionsKilled: 0,
        win: true,
        soloKills: 0,
        legendaryCount: 0,
        damagePerMinute: 0,
        dragonTakedowns: 0,
        epicMonsterSteals: 0,
        baronTakedowns: 0,
        voidMonsterKill: 0,
        perfectDragonSoulsTaken: 0,
        elderDragonMultikills: 0,
        killParticipation: 0
      )
    )
    MatchCardView(
      matchData: LOLMatchEntity(
        matchId: "string",
        matchType: .freeRank,
        championName: "아트록스",
        doubleKills: 1,
        firstBloodKill: true,
        teamPosition: .top,
        pentaKills: 0,
        assists: 5,
        deaths: 3,
        kills: 5,
        kda: 3.3,
        firstBloodAssist: true,
        firstTowerAssist: true,
        firstTowerKill: true,
        goldPerMinute: 300,
        gameEndedInEarlySurrender: true,
        gameEndedInSurrender: true,
        timePlayed: 0,
        totalMinionsKilled: 0,
        win: false,
        soloKills: 0,
        legendaryCount: 0,
        damagePerMinute: 0,
        dragonTakedowns: 0,
        epicMonsterSteals: 0,
        baronTakedowns: 0,
        voidMonsterKill: 0,
        perfectDragonSoulsTaken: 0,
        elderDragonMultikills: 0,
        killParticipation: 0
      )
    )
  }
  .padding()
}
