//
//  UserProfileView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/22/24.
//

import SwiftUI

public struct UserProfileView: View {
  
  let userData: RiotAccountDTO
  
  public init(userData: RiotAccountDTO) {
    self.userData = userData
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      userInfoTitle(userData: userData)
      
      updateSection()
      
      rankInfo()
      
      ScrollView {
        
      }
    }
    .ignoresSafeArea(edges: .top)
    .background(.glBackground1)
  }
}

private extension UserProfileView {
  
  @ViewBuilder
  func userInfoTitle(userData: RiotAccountDTO) -> some View {
    ZStack(alignment: .bottom) {
      CachedImageView(url: URL(string: userData.backgroundImageUrl))
        .scaledToFit()
        .frame(width: .infinity)
      
      HStack(alignment: .center, spacing: 0) {
        CachedImageView(url: URL(string: userData.summonerIconUrl))
          .clipShape(Circle())
          .frame(width: 80, height: 80)
          .overlay(alignment: .bottom) {
            Text(userData.summonerLevel.description)
              .glFont(.body2Bold)
              .foregroundStyle(.white)
              .padding(.vertical, 2)
              .padding(.horizontal, 8)
              .background(
                Capsule()
                  .fill(.glBackground2)
              )
              .offset(y: 4)
          }
          .padding(.trailing, 20)
        
        VStack(alignment: .leading, spacing: 10) {
          HStack(spacing: 8) {
            Text(userData.summonerName)
              .glFont(.title1)
              .foregroundStyle(.white)
            
            Text("# \(userData.summonerTag)")
              .glFont(.body1Bold)
              .foregroundStyle(.glGray2)
          }
          
          HStack(spacing: 8) {
            Text("레더 랭킹")
          }
        }
        
        Spacer()
      }
      .padding(.bottom, 30)
      .padding(.horizontal, GridRules.globalHorizontalPadding)
    }
  }
  
  @ViewBuilder
  func updateSection() -> some View {
    HStack(spacing: 0) {
      GLButton(
        title: "전적 갱신",
        isValid: true, action: { },
        activeColor: .glPrimary4
      )
      
      // TODO: Update Date
      Text("최근 업데이트: 하루전")
        .glFont(.body2Bold)
        .foregroundStyle(.glGray1)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
    .padding(.vertical, 12)
    .padding(.horizontal, GridRules.globalHorizontalPadding)
    .background(.glBackground1)
  }

  @ViewBuilder
  func rankInfo() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        RankCardView(rankData: RankDTO.toRankEntity(type: .soloRank, data: userData.soloRank))
        RankCardView(rankData: RankDTO.toRankEntity(type: .freeRank, data: userData.teamRank))
      }
      .padding(.horizontal, GridRules.globalHorizontalPadding)
    }
    .frame(height: 240)
  }
}

#Preview {
  UserProfileView(userData: RiotAccountDTO(
    userId: "ecc553e3-3adc-4710-9d53-67851f5d67ff",
    nickname: "기백있는 아이번",
    backgroundImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-background/Nautilus_0.jpg",
    email: "jdh1109ok@naver.com",
    puuid: "HL5muZIQq3OAA87WRlVh2z8ndQ4mPmjVv2pDMxiZbvOiYepS19VAcZ3SpWvEOrZhCmbu_ajpoR2Hpg",
    summonerId: "WbcIo9pJ5P542CxTRtqnqUTltD8NYC13xWhx2Rc_f7y1CK0",
    summonerName: "Legend Mouse",
    summonerTag: "KR1",
    summonerIconUrl: "https://ddragon.leagueoflegends.com/cdn/14.18.1/img/profileicon/746.png",
    revisionDate: "2024-11-21T17:49:35.672165",
    summonerLevel: 249,
    total: RankDTO(
      rankImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/lol-tier-image/bronze.png",
      tier: "BRONZE",
      rank: "III",
      leaguePoints: 40,
      wins: 13,
      losses: 7,
      winRate: 0.65,
      kda: 4.0894308943089435,
      avgKills: 11.15,
      avgDeaths: 6.15,
      avgAssists: 14.0,
      avgCs: 143.95,
      best3champions: [
        ChampionDTO(
          championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Jhin_0.jpg",
          kills: 12.25,
          deaths: 3.75,
          assists: 7.125,
          winRate: 0.875,
          wins: 7,
          losses: 1
        ),
        ChampionDTO(
          championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Aphelios_0.jpg",
          kills: 10.0,
          deaths: 11.0,
          assists: 16.5,
          winRate: 1.0,
          wins: 2,
          losses: 0
        ),
        ChampionDTO(
          championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Ezreal_0.jpg",
          kills: 14.5,
          deaths: 8.0,
          assists: 14.0,
          winRate: 0.5,
          wins: 1,
          losses: 1
        )
      ],
      veteran: false,
      inactive: false,
      freshBlood: false,
      hotStreak: false
    ),
    soloRank: RankDTO(
      rankImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/lol-tier-image/bronze.png",
      tier: "BRONZE",
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
    ),
    teamRank: RankDTO(
      rankImageUrl: "",
      tier: "UNRANKED",
      rank: "",
      leaguePoints: 0,
      wins: 5,
      losses: 4,
      winRate: 0.5555555555555556,
      kda: 3.6842105263157894,
      avgKills: 8.222222222222221,
      avgDeaths: 4.222222222222222,
      avgAssists: 7.333333333333333,
      avgCs: 159.44444444444446,
      best3champions: [
        ChampionDTO(
          championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Jhin_0.jpg",
          kills: 11.333333333333334,
          deaths: 3.3333333333333335,
          assists: 4.333333333333333,
          winRate: 0.6666666666666666,
          wins: 2,
          losses: 1
        ),
        ChampionDTO(
          championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Ezreal_0.jpg",
          kills: 7.5,
          deaths: 3.0,
          assists: 11.5,
          winRate: 0.5,
          wins: 1,
          losses: 1
        ),
        ChampionDTO(
          championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Xerath_0.jpg",
          kills: 13.0,
          deaths: 3.0,
          assists: 14.0,
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
  )
}
