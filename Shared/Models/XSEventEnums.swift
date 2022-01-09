//
//  XSEventEnums.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/8/22.
//

import Foundation
import SwiftUI

enum XSEventFamily: String, Codable{
    case urgeFamily = "urgeFamily"
    case energyFamily = "energyFamily"
    
}

enum UrgeFamilyType: String, Codable {
    case urge = "Urge"
    case atomicLapse = "Lapse"
    case lapseStart = "Lapse Start"
    case lapseEnd = "Lapse End"
    case dangerZone = "Danger Zone"
    
    var textColor: Color{
        switch self{
        case .urge: return .yellow
        case .dangerZone: return .orange
        case .atomicLapse, .lapseStart: return .red
        default: return .blue
        }
    }
}
