//
//  TimeTrackingAttributes.swift
//  FMKLApp
//
//  Created by Данила Рахманов on 18.09.2024.
//

import Foundation
import ActivityKit

struct TimeTrackingAttributes: ActivityAttributes {
    public typealias TimeTrackingStatus = ContentState
    
    public struct ContentState: Codable, Hashable {
        var startTime: Date
    }
}
