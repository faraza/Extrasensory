//
//  ESEventsListView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventsListView: View {
    var session = WCSessionManager()
    let events: [XSEvent]
    
    var body: some View {
        let groupedEvents = XSEvent.groupEventsByDate(events: events)
        List{
            ForEach(groupedEvents){ group in
                Section(header: Text(group.groupDate)){
                    ForEach(group.events){ event in
                        XSEventCard(event: event)
                    }
                }
            }
        }
    }
}

struct XSEventsListView_Previews: PreviewProvider {
    static var previews: some View {
        XSEventsListView(events: XSEvent.sampleData)
    }
}
