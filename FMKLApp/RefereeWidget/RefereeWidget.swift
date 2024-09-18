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
        
        ActivityConfiguration(for: TimeTrackingAttributes.self) { context in
            RefereeWidgetView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    VStack {
                        Image(.sBUSUS)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                        Text("BUSUS")
                            .font(.custom("Jellee-Roman", size: 13))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.gradient)
                    }
                    .padding(.leading)
                    .padding(.top, 5)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    VStack {
                        Image(.sCSAK)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                        Text("CSAK")
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
                        Text("2 - 1")
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
                            Text("Kirill Filatov")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "rectangle.portrait.fill")
                                .foregroundColor(.red)
                            Text("Abubakr Rakhimov")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                    }
                    .padding(.top, 5)
                }
            } compactLeading: {
                HStack {
                    Image(.sBUSUS)
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(13)
                    Text("2")
                        .font(.custom("Jellee-Roman", size: 15))
                        .foregroundStyle(.white.gradient)
                }
            } compactTrailing: {
                HStack {
                    Text("1")
                        .font(.custom("Jellee-Roman", size: 15))
                        .foregroundStyle(.white.gradient)
                    Image(.sCSAK)
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(13)
                }
            } minimal: {
                Image(systemName: "soccerball.inverse")
                    .foregroundStyle(.green.gradient)
            }

        }
    }
}

struct RefereeWidgetView: View {
    let context: ActivityViewContext<TimeTrackingAttributes>
    
    var body: some View {
        VStack {
            Text(context.state.startTime, style: .timer)
                .font(.custom("Jellee-Roman", size: 25))
                .foregroundColor(.pink)
                .multilineTextAlignment(.center)
            
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.white.gradient)
    }
}
