//
//  ESEventsListView.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventsListView: View {
    let events: [XSEvent]
    var body: some View {
        List{
            ForEach(events){ event in
               XSEventCard(event: event)
            }
        }
    }
}

struct XSEventsListView_Previews: PreviewProvider {
    static var previews: some View {
        XSEventsListView(events: XSEvent.sampleData)
    }
}
