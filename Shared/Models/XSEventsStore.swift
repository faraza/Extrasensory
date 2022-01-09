//
//  XSEventsStore.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/2/22.
//

import Foundation
import os

class XSEventsStore: ObservableObject{
    static var events: [XSEventRawData] = []
    private static var loadComplete = false
    private static var savedEventsWaitingForLoad: [XSEventRawData] = []
                    
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("xsevents.data")
    }
        
    static func load(completion: @escaping (Result<[XSEventRawData], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                var savedEvents = try JSONDecoder().decode([XSEventRawData].self, from: file.availableData)
                DispatchQueue.main.async {
                    savedEvents.append(contentsOf: savedEventsWaitingForLoad)
                    completion(.success(savedEvents))
                    events = savedEvents
//                    completion(.success(XSEvent.sampleData))
//                    completion(.success([]))
                    loadComplete = true
                    os_log("%@", type: .info, "Loaded \(fileURL). Length: \(savedEvents.count)")
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    enum FileSaveError: Error{
        case dataLossSafeguard
    }
    
    static func save(events: [XSEventRawData], completion: @escaping (Result<Int, Error>)->Void) {
        return
        
      /*  if(!loadComplete){
            os_log("ERROR - Loading note complete yet. Preventing save.")
            savedEventsWaitingForLoad = events
            return
        }
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(events)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(events.count))
                    os_log("%@", type: .info, "Saved \(outfile). Length: \(events.count)")
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        } */
    }
    
}
