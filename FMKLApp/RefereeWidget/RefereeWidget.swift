//
//  RefereeWidget.swift
//  RefereeWidget
//
//  Created by Данила Рахманов on 18.09.2024.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct RefereeWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MatchTrackingAttributes.self) { context in
            RefereeWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                let team1Name = context.state.team1Name
                let team2Name = context.state.team2Name
                
                let team1NameEmpty = team1Name == nil
                let team2NameEmpty = team2Name == nil
                
                let team1Score = context.state.team1Score
                let team2Score = context.state.team2Score
                
                let lastGoalAuthor = context.state.lastGoalAuthor
                let lastCardAuthor = context.state.lastCardAuthor
                
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        if team1NameEmpty {
                            Text("?")
                                .font(.custom("Jellee-Roman", size: 25))
                                .frame(width: 60, height: 60)
                                .background(Circle().fill(.gray))
                                .foregroundColor(.black)
                            
                        } else {
                            Image(uiImage: UIImage(named: team1Name!)!.resize(toDimension: 128))
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                        }
                        Text(team1NameEmpty ? "-" : "\(team1Name!)")
                            .font(.custom("Jellee-Roman", size: 13))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.gradient)
                    }
                    .padding(.leading)
                    .padding(.top, 5)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        if team2NameEmpty {
                            Text("?")
                                .font(.custom("Jellee-Roman", size: 25))
                                .frame(width: 60, height: 60)
                                .background(Circle().fill(.gray))
                                .foregroundColor(.black)
                            
                        } else {
                            Image(uiImage: UIImage(named: team2Name!)!.resize(toDimension: 128))
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                        }
                        Text(team2NameEmpty ? "-" : "\(team2Name!)")
                            .font(.custom("Jellee-Roman", size: 13))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.gradient)
                    }
                    .padding(.trailing)
                    .padding(.top, 5)
                }
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        Text(context.state.startTime, style: .timer)
                            .font(.custom("Jellee-Roman", size: 14))
                            .foregroundColor(.green)
                            .multilineTextAlignment(.center)
                        Text("\(team1Score == nil ? 0 : team1Score!) - \(team2Score == nil ? 0 : team2Score!)")
                            .font(.custom("Jellee-Roman", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.gradient)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Spacer()
                        HStack {
                            Image(systemName: "soccerball.inverse")
                            Text(lastGoalAuthor == nil ? "-" : String(lastGoalAuthor!))
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "rectangle.portrait.fill")
                                .foregroundColor(
                                    lastCardAuthor == nil || (lastCardAuthor != nil && lastCardAuthor?.isCardRed == true) ?
                                        .redCard : .yellowCard
                                )
                            Text(lastCardAuthor == nil ? "-" : String(lastCardAuthor!.playerName))
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding(.top, 5)
                }
            } compactLeading: {
                let team1Name = context.state.team1Name
                let team1Score = context.state.team1Score
                
                HStack {
                    if team1Name == nil {
                        Text("?")
                            .font(.custom("Jellee-Roman", size: 18))
                            .frame(width: 26, height: 26)
                            .background(Circle().fill(.gray))
                            .foregroundColor(.black)
                    } else {
                        Image(uiImage: UIImage(named: team1Name!)!.resize(toDimension: 128))
                            .resizable()
                            .frame(width: 26, height: 26)
                            .cornerRadius(13)
                    }
                    
                    Text(team1Score == nil ? "-" : "\(team1Score!)")
                        .font(.custom("Jellee-Roman", size: 15))
                        .foregroundStyle(.white.gradient)
                }
            } compactTrailing: {
                let team2Name = context.state.team2Name
                let team2Score = context.state.team2Score
                
                HStack {
                    Text(team2Score == nil ? "-" : "\(team2Score!)")
                        .font(.custom("Jellee-Roman", size: 15))
                        .foregroundStyle(.white.gradient)
                    
                    if team2Name == nil {
                        Text("?")
                            .font(.custom("Jellee-Roman", size: 18))
                            .frame(width: 26, height: 26)
                            .background(Circle().fill(.gray))
                            .foregroundColor(.black)
                    } else {
                        Image(uiImage: UIImage(named: team2Name!)!.resize(toDimension: 128))
                            .resizable()
                            .frame(width: 26, height: 26)
                            .cornerRadius(13)
                    }
                }
            } minimal: {
                Image(systemName: "soccerball.inverse")
                    .foregroundStyle(.green.gradient)
            }

        }
    }
}

struct RefereeWidgetView: View {
    let context: ActivityViewContext<MatchTrackingAttributes>
    
    var body: some View {
        let team1Name = context.state.team1Name
        let team2Name = context.state.team2Name
        
        let team1NameEmpty = team1Name == nil
        let team2NameEmpty = team2Name == nil
        
        let team1Score = context.state.team1Score
        let team2Score = context.state.team2Score
        
        ZStack {
            HStack {
                Spacer()
                HStack {
                    if team1NameEmpty {
                        Text("?")
                            .font(.custom("Jellee-Roman", size: 25))
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(.gray))
                            .foregroundColor(.black)
                        
                    } else {
                        Image(uiImage: UIImage(named: team1Name!)!.resize(toDimension: 128))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    }
                    VStack {
                        Text(team1NameEmpty ? "-" : "\(team1Name!)")
                            .font(.custom("Jellee-Roman", size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.gray.gradient)
                        Text(team1Score == nil ? "-" : "\(team1Score!)")
                            .font(.custom("Jellee-Roman", size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.gradient)
                    }
                }
                Spacer()
                Text(context.state.startTime, style: .timer)
                    .font(.custom("Jellee-Roman", size: 20))
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                Spacer()
                HStack {
                    VStack {
                        Text(team2NameEmpty ? "-" : "\(team2Name!)")
                            .font(.custom("Jellee-Roman", size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.gray.gradient)
                        Text(team2Score == nil ? "-" : "\(team2Score!)")
                            .font(.custom("Jellee-Roman", size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.gradient)
                    }
                    if team2NameEmpty {
                        Text("?")
                            .font(.custom("Jellee-Roman", size: 25))
                            .frame(width: 50, height: 50)
                            .background(Circle().fill(.gray))
                            .foregroundColor(.black)
                        
                    } else {
                        Image(uiImage: UIImage(named: team2Name!)!.resize(toDimension: 128))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    }
                }
                Spacer()
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.black)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
