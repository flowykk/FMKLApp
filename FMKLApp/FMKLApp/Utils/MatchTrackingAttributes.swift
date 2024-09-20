//
//  MatchTrackingAttributes.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 18.09.2024.
//

import Foundation
import ActivityKit

struct MatchTrackingAttributes: ActivityAttributes {
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: Date
        
        var team1Name: String?
        var team2Name: String?
        
        var team1Score: Int?
        var team2Score: Int?
        
        var lastGoalAuthor: String?
        var lastCardAuthor: String?
    }
}
