//
//  JSONWriter.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 1/8/22.
//

import Foundation

/**
 Exports to JSON
 Later, maybe we'll also support CSV
 */
class XSEventExporter{
    
    static func exportToJSON(events: [XSEventRawData], completion: @escaping (Result<Int, Error>)->Void) {

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
    
    private static func fileURL() throws -> URL {
            let fileName = "ExtrasensoryEvents_\(Date().timeIntervalSince1970).json"
            return try FileManager.default.url(for: .documentDirectory,
                                           in: .userDomainMask,
                                           appropriateFor: nil,
                                           create: false)
                .appendingPathComponent(fileName)
        }

}

