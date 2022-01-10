//
//  GoalCDInterface.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/9/22.
//

import Foundation

/**
 Interface with core data.
 
 This is necessary because of re-indexing. There are two lists of goal entities - active and inactive.
 The position of the inactive list doesn't matter, but the position of the active one does - that's the order in which the user will see the items,
 and is manually set by them.
 Core data doesn't cleanly support this out of the box, so we have an index variable that gets recalculated for everyone once the list is updated.
 */
class GoalCDInterface{
    
}
