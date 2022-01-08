//
//  XSEventEntity.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/7/22.
//

import Foundation
import CoreData

extension XSEventEntity{
    static func getAllEvents() -> NSFetchRequest<XSEventEntity>{
        let request: NSFetchRequest<XSEventEntity> = XSEventEntity.fetchRequest() as! NSFetchRequest<XSEventEntity>
        return request
    }
}
