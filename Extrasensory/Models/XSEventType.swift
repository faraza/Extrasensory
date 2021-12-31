//
//  ESEventTypes.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

enum XSEventType: String, Codable {
    case urge = "Urge"
    case atomicLapse = "Lapse"
    case lapseStart = "Lapse Start"
    case lapseEnd = "Lapse End"
    
    var textColor: Color{
        switch self{
        case .urge: return .yellow
        case .atomicLapse, .lapseStart: return .red
        default: return .black
        }
    }
}
