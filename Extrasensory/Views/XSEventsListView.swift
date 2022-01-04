//
//  ESEventsListView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventsListView: View {
    var session = WCSessionManager()
    @Binding var events: [XSEvent]
    @Environment(\.scenePhase) private var scenePhase
    
    let saveAction: ()->Void
    
    var body: some View {
        let groupedEvents = XSEvent.groupEventsByDate(events: events)
        NavigationView{
            List{
                ForEach(groupedEvents){ group in
                    Section(header: Text(group.groupDate)){
                        ForEach(group.events){ event in
                            NavigationLink(destination: XSEventDetailsView(event: event){event, newText in
                                print("Descripton text updated. New text: \(newText). Old text: \(event.description)") //TODO: Delete
                                let index = events.firstIndex(where: {$0.timestamp == event.timestamp})
                                if(index != nil){
                                    events[index!].description = newText
                                }
                            }){
                                XSEventCardView(event: event)
                            }
                        }
                        .onDelete(){ offsets in
                            for offset in offsets{
                                let eventToDelete = group.events[offset]
                                if let index = events.firstIndex(where: {$0.timestamp == eventToDelete.timestamp}){
                                    events.remove(at: index)
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            .navigationTitle("Events")
        }
    }
}

struct XSEventsListView_Previews: PreviewProvider {
    @State static var sampleEvents = XSEvent.sampleData
    static var previews: some View {
        XSEventsListView(events: $sampleEvents){}
    }
}
