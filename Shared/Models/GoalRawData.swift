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
class GoalRawData: Identifiable, Codable, Hashable{
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

extension GoalRawData{
    func encode() -> Data?{
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(self)
            return data
        }
        catch{
            return nil
        }
    }        
}

extension GoalRawData{
    static func == (first: GoalRawData, second: GoalRawData) -> Bool{
        return (first.id == second.id)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension GoalRawData{
    enum DictionaryKeys: String{
        case numberOfGoals = "numberOfGoals"
    }
}
