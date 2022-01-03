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
        List{
            ForEach(groupedEvents){ group in
                Section(header: Text(group.groupDate)){
                    ForEach(group.events){ event in
                        XSEventCard(event: event)
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct XSEventsListView_Previews: PreviewProvider {
    @State static var sampleEvents = XSEvent.sampleData
    static var previews: some View {
        XSEventsListView(events: $sampleEvents){}
    }
}
