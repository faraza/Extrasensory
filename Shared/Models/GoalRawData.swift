//
//  GoalRawData.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/10/22.
//

import Foundation

/**
 Codable version of the entity to be transmitted to the watch.
 Not asking if isActive because they should all be active
 */
class GoalRawData: Identifiable, Codable{
    let id: UUID
    let shortName: String
    let identifierKey: String
    let activeListPosition: Int
    
    init(id: UUID = UUID(), shortName: String, identifierKey: String, activeListPosition: Int){
        self.id = id
        self.shortName = shortName
        self.identifierKey = identifierKey
        self.activeListPosition = activeListPosition
    }
}
