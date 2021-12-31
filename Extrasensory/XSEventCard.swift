//
//  ESEventCard.swift
//  Extrasensory
//
//  Created by Faraz Abidi on 12/30/21.
//

import SwiftUI

struct XSEventCard: View {
    let event: XSEvent
    var body: some View {
        HStack{
            Text(event.goal)
                .accessibilityLabel("goal")
            Text(event.typeOfEvent.rawValue)
            Text(event.getPrintableTime())
        }
    }
}

struct XSEventCard_Previews: PreviewProvider {
    static var previews: some View {
        XSEventCard(event: XSEvent.sampleData[0])
//            .previewLayout(.sizeThatFits)
    }
}
