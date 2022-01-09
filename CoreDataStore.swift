//
//  CoreDataStore.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/7/22.
//

import Foundation
import CoreData

class CoreDataStore{
    static let shared = CoreDataStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores{ description, error in
            if let error = error{
                print(error)
            }
        }
        return container
    }()
    
    public func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                print(error)
            }
        }
    }
    
    init(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(xsEventAddedFromWatch(notification:)), name: Notification.Name(NotificationTypes.xsEventReceivedFromWatch.rawValue), object: nil)

    }
    
    @objc func xsEventAddedFromWatch(notification: Notification){
        guard let newEventRawData = notification.object as? XSEventRawData
        else{
            print("No event added from notificationCenter")
            return
        }
        let event = XSEvent(context: persistentContainer.viewContext)
        event.timestamp = Date(timeIntervalSince1970: newEventRawData.timestamp) //TODO: Fix
        event.eventFamily = XSEventFamily.urgeFamily.rawValue
        event.urgeFamilyType = newEventRawData.typeOfEvent.rawValue
        event.goalKey = newEventRawData.goal
        saveContext()        
    }
}
