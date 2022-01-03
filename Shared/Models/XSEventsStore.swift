//
//  XSEventsStore.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/2/22.
//

import Foundation

class XSEventsStore: ObservableObject{
    @Published var events: [XSEvent] = []
    
    init(){
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(xsEventAdded(notification:)), name: Notification.Name(NotificationTypes.xsEventReceived.rawValue), object: nil)

    }
        
    
    @objc func xsEventAdded(notification: Notification){
        guard let newEvent = notification.object as? XSEvent
        else{
            print("No event added from notificationCenter")
            return
        }
        events.append(newEvent)
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("xsevents.data")
    }
        
    static func load(completion: @escaping (Result<[XSEvent], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrums = try JSONDecoder().decode([XSEvent].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyScrums))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(events: [XSEvent], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(events)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(events.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
