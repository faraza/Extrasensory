//
//  ESEventsListView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventsListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: XSEventEntity.entity(), sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    private var events: FetchedResults<XSEventEntity>
    
    var _previewEvents: [XSEventEntity]? = nil
        
    var body: some View {
        let groupedEvents = _previewEvents == nil ? XSEventEntity.groupEventsByDate(events: events) : XSEventEntity.groupEventsByDate(events: _previewEvents!)
        
        NavigationView{
            List{
                ForEach(groupedEvents){ group in
                    Section(header: Text(group.groupDate)){
                        ForEach(group.events){ event in
                            XSEventCardView(event: event)
                        }
                       ForEach(group.events){ event in
                            NavigationLink(destination: XSEventDetailsView(event: event){event, newText in
                                let index = events.firstIndex(where: {$0.timestamp == event.timestamp})
                                if(index != nil){
//                                    events[index!].description = newText
                                    /*XSEventsStore.save(events: events) { result in
                                        if case .failure(let error) = result {
                                            fatalError(error.localizedDescription)
                                        }
                                    } */
                                }
                            }){
                                XSEventCardView(event: event)
                            }
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let eventToDelete = group.events[offset]
                                if let index = events.firstIndex(where: {$0.timestamp == eventToDelete.timestamp}){
//                                    events.remove(at: index)
                                }
                            }
//                            XSEventsStore.save(events: events){_ in}
                        }
                    }
                }
            }
            .navigationTitle("Saved Events")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct XSEventsListView_Previews: PreviewProvider {
    
    static var previews: some View {
        XSEventsListView(_previewEvents: XSEventEntity.sampleData)
    }
}
