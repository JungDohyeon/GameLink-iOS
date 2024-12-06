//
//  UserCarouselCardView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import SwiftUI

struct UserCarouselCardView: View {
  
  let userData: ChatRoomUserListDetailDTO
  
  init(userData: ChatRoomUserListDetailDTO) {
    self.userData = userData
  }
  
  var body: some View {
    VStack(spacing: 0) {
      userInfoSection()
        .padding(.top, 48)
      
      midSection()
        .padding(.top, 26)
      
      mostChampion()
        .padding(.top, 50)
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 20)
    .background(
      RoundedRectangle(cornerRadius: 6)
        .fill(
          LinearGradient(
            colors: [.glWinBlue, .glLooseRed],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .stroke(
          LinearGradient(
            colors: [.white.opacity(0.6), .white.opacity(0)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          ),
          lineWidth: 1.0
        )
    )
  }
}

private extension UserCarouselCardView {
  
  @ViewBuilder
  func userInfoSection() -> some View {
    VStack(spacing: 16) {
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
      
      HStack(alignment: .center, spacing: 8) {
        Text(userData.summonerName)
          .glFont(.title1)
          .foregroundStyle(.white)
        
        Text("#\(userData.summonerTag)")
          .glFont(.body1Bold)
          .foregroundStyle(.glGray2)
      }
    }
  }
  
  @ViewBuilder
  func midSection() -> some View {
    VStack(spacing: 0) {
      HStack(alignment: .center) {
        Image(uiImage: LOLTier.stringToLOLTier(tier: userData.gameInfo.tier).tierImage)
          .resizable()
          .frame(width: 80, height: 80)
          .frame(maxWidth: .infinity, alignment: .center)
        
        VStack(alignment: .leading, spacing: 7) {
          Text(userData.gameInfo.tier)
            .glFont(.body2Bold)
            .foregroundStyle(.white)
          
          VStack(alignment: .leading, spacing: 2) {
            Text("\(userData.gameInfo.leaguePoints) LP")
            Text("\(userData.gameInfo.wins)승 \(userData.gameInfo.losses)패 (\(String(format: "%.2f", userData.gameInfo.winRate * 100))%)")
          }
          .glFont(.navi)
          .foregroundStyle(.glGray1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
      }
      
      Divider()
        .frame(height: 1)
        .overlay(.glGray2)
      
      HStack(alignment: .center, spacing: 0) {
        VStack(alignment: .leading, spacing: 10) {
          Text("최근 20 경기 정보")
            .glFont(.body2Bold)
            .foregroundStyle(.glGold1)
          
          HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
              Text("승률")
                .glFont(.navi)
                .foregroundStyle(.glGray1)
              
              Text("KDA")
                .glFont(.navi)
                .foregroundStyle(.glGray1)
            }
            
            VStack(alignment: .leading, spacing: 4) {
              Text("\(String(format: "%.2f", userData.gameInfo.winRate * 100)) %")
                .glFont(.navi).bold()
                .foregroundStyle(.white)
              
              Text("\(String(format: "%.1f", userData.gameInfo.avgKills)) / \(String(format: "%.1f", userData.gameInfo.avgDeaths)) / \(String(format: "%.1f", userData.gameInfo.avgAssists))")
                .glFont(.navi).bold()
                .foregroundStyle(.white)
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.top, 12)
        
        Divider()
          .frame(width: 1, height: 80)
          .overlay(.glGray2)
        
        if let positionImage = LOLPosition.stringToPosition(position: userData.position).positionImage {
          Image(uiImage: positionImage)
            .resizable()
            .frame(width: 50, height: 50)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 12)
        } else {
          Text("상관없음")
            .glFont(.body1Bold)
            .foregroundStyle(.glGray1)
            .frame(maxWidth: .infinity)
        }
      }
    }
  }
  
  @ViewBuilder
  func mostChampion() -> some View {
    VStack(alignment: .leading, spacing: 30) {
      Text("모스트 챔피언 (top 3)")
        .glFont(.body1Bold)
        .foregroundStyle(.glGold1)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      HStack(spacing: 0) {
        ForEach(userData.gameInfo.best3champions, id: \.self) { champion in
          VStack(spacing: 8) {
            CachedImageView(url: URL(string: champion.championImageUrl))
              .clipShape(Circle())
              .frame(width: 80, height: 80)
            
            Text("\(String(format: "%.1f", champion.kills)) / \(String(format: "%.1f", champion.deaths)) / \(String(format: "%.1f", champion.assists))")
              .glFont(.navi).bold()
              .foregroundStyle(.glGray1)
          }
          .frame(maxWidth: .infinity)
        }
      }
    }
  }
}

#Preview {
  UserCarouselCardView(
    userData:
      ChatRoomUserListDetailDTO(
        userId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        nickname: "string",
        backgroundImageUrl: "https://ddragon.leagueoflegends.com/cdn/14.18.1/img/profileicon/1641.png",
        email: "string",
        puuid: "string",
        summonerId: "string",
        summonerName: "string",
        summonerTag: "string",
        summonerIconUrl: "string",
        revisionDate: "2024-11-19T17:11:54.556Z",
        summonerLevel: 0,
        position: "string",
        gameInfo: GameInfoDTO(
          gameType: "SOLO_RANK",
          rankImageUrl: "string",
          tier: "string",
          rank: "string",
          leaguePoints: 0,
          wins: 0,
          losses: 0,
          winRate: 0,
          kda: 0,
          avgKills: 0,
          avgDeaths: 0,
          avgAssists: 0,
          avgCs: 0,
          best3champions: [
            ChampionDTO(
              championImageUrl: "https://gamelink-dev.s3.ap-northeast-2.amazonaws.com/champion-profile/Thresh_0.jpg",
              kills: 0,
              deaths: 0,
              assists: 0,
              winRate: 0,
              wins: 0,
              losses: 0
            )
          ],
          veteran: true,
          inactive: true,
          freshBlood: true,
          hotStreak: true
        )
      )
  )
  .padding()
  .background(.glBackground1)
}

